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

  it 'should handle a large number of films' do
    request = stub(:query => {}, :path => "/films" )
    film_names = ['The Godfather', 'Birdemic', 'M', 'Seven', 'Suspicion', 'Notorious', 'Frenzy', 'Torn Curtain', 'Annie Hall', 'Manhatten', 'Gone With The Wind', 'Metropolis', 'The Great Dictator', 'Siwss Young Boys', 'All About Eve', 'It Happened One Night']
    time = Time.new 2012, 6, 14, 17, 13, 0
    films = film_names.map { |name| Showing.new name, (time += 4.hours), (time + 2.hours), 'ITV', 7.3 }
    cache.stub(:get_films => films)
    film_server.handleGET request, response
  end

  it 'should return a list of films' do
    request = stub(:query => {}, :path => "/films" )
    film1 = Showing.new 'The Godfather', Time.now, Time.now, 'ITV'
    film2 = Showing.new 'Birdemic', Time.now, Time.now, 'Film 4'
    cache.stub(:get_films => "films json")
    film_server.handleGET request, response
    response.body.should == "films json"
  end

  it 'should ignore requests which start with an unrecognised path' do
    request = stub(:query => {'name' => 'The Godfather'}, :path => "/wibble" )
    film_server.handleGET request, response
    response.body.should == "Unexpected url.  Should be in the format [ip:port]/films"
  end 

  it 'should allow caching of a configurable number of days' do
    request = stub(:query => {'days' => '4'}, :path => "/cache" )
    Cache.should_receive(:build).with(anything(), anything(), 4.days)
    film_server.handleGET request, response
  end

  it 'should respond to a cache call by building up the cache for 7 days' do
    request = stub(:query => {}, :path => "/cache" )
    Cache.should_receive(:build).with(anything(), anything(), 7.days)
    film_server.handleGET request, response
  end

  it 'should integrate with the cache' do
    film_server = FilmServer.new
    tv = stub(:get_films => [], :films_retrieved_up_to? => true)
    reviewer = stub
    Cache.build tv, reviewer
    request = stub(:query => {}, :path => "/films" )
    film_server.handleGET request, response
    response.body.should == "[]"
  end
end

