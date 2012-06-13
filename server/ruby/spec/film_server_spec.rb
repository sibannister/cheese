require 'film_server'
require 'film_reviewer'
require 'net/http'
require 'fixnum'

class MockResponse
  attr_accessor :body
end

describe FilmServer do
  let (:cache) { stub }
  let (:film_server) { FilmServer.new cache  }
  let (:response) { MockResponse.new }


  it 'should return a list of films' do
    FilmServer.build_cache 0
    request = stub(:query => {}, :path => "/films" )
    film1 = Showing.new 'The Godfather', Time.now, Time.now
    film2 = Showing.new 'Birdemic', Time.now, Time.now
    cache.stub(:get_films => [film1, film2])
    film_server.handleGET request, response
    response.body.should == '[' + film1.to_json + ', ' + film2.to_json + ']'
  end

  it 'should return a list of channels' do
    request = stub(:query => {}, :path => "/channels" )
    channel = Channel.new "Film 4", 123
    cache.stub(:get_channels => [channel])
    film_server.handleGET request, response
    response.body.should == '[' + channel.to_json + ']'
  end

  it 'should ignore requests which start with an unrecognised path' do
    request = stub(:query => {'name' => 'The Godfather'}, :path => "/wibble" )
    film_server.handleGET request, response
    response.body.should == "Unexpected url.  Should be in the format [ip:port]/films"
  end 

  it 'should allow caching of a configurable number of days' do
    request = stub(:query => {'days' => '4'}, :path => "/cache" )
    Cache.should_receive(:build).with(anything(), anything(), anything(), 4.days)
    film_server.handleGET request, response
  end

  it 'should respond to a cache call by building up the cache for 7 days' do
    request = stub(:query => {}, :path => "/cache" )
    Cache.should_receive(:build).with(anything(), anything(), anything(), 7.days)
    film_server.handleGET request, response
  end
end

