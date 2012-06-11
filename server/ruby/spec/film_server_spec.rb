require 'film_server'
require 'film_reviewer'
require 'net/http'

class MockResponse
  attr_accessor :body
end

describe FilmServer do
  let (:cache) { stub }
  let (:film_server) { FilmServer.new cache  }
  let (:response) { MockResponse.new }

  it 'should begin caching films on start up' do
    FilmServer.new cache
  end

  it 'should return a list of films' do
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
end

