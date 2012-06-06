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
    cache.should_receive :begin_caching
    FilmServer.new cache
  end

  it 'should return a list of films' do
    cache.should_receive :begin_caching
    request = stub(:query => {}, :path => "/films" )
    film1 = Showing.new 'The Godfather', 2.3, Time.now, Time.now
    film2 = Showing.new 'Birdemic', 5.9, Time.now, Time.now
    cache.stub(:get_films => [film1, film2])
    film_server.handleGET request, response
    response.body.should == '[' + film1.to_json + ', ' + film2.to_json + ']'
  end

  it 'should ignore requests which do not start with the "/films" path' do
    cache.should_receive :begin_caching
    request = stub(:query => {'name' => 'The Godfather'}, :path => "/wibble" )
    film_server.handleGET request, response
    response.body.should == "Unexpected url.  Should be in the format [ip:port]/films"
  end 
end

