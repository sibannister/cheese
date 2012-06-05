require 'film_server'
require 'film_reviewer'
require 'net/http'

class MockResponse
  attr_accessor :body
end

describe FilmServer do
  let (:reviewer) { stub }
  let (:tv) { stub }
  let (:film_server) { FilmServer.new(reviewer, tv) }
  let (:response) { MockResponse.new }

  it 'should begin caching films on start up' do
    cache = stub
    cache.should_receive :begin_caching
    FilmServer.new reviewer, tv, cache
  end

  it 'should return a list of films' do
    request = stub(:query => {}, :path => "/films" )
    reviewer.should_receive(:review).with('The Godfather').and_return(2.3)
    reviewer.should_receive(:review).with('Birdemic').and_return(5.9)
    film1 = Showing.new 'The Godfather', 2.3, Time.now, Time.now
    film2 = Showing.new 'Birdemic', 5.9, Time.now, Time.now
    tv.stub(:get_films => [film1, film2])
    film_server.handleGET request, response
    response.body.should == '[' + film1.to_json + ', ' + film2.to_json + ']'
  end

  it 'should allow you to retrieve films for a given number of days ahead' do
    request = stub(:query => { "days" => "1" }, :path => "/films" )
    tv.stub(:get_films => [])
    tv.should_receive(:get_films).with(1)
    film_server.handleGET request, response
  end

  it 'should ignore requests which do not start with the "/films" path' do
    request = stub(:query => {'name' => 'The Godfather'}, :path => "/wibble" )
    film_server.handleGET request, response
    response.body.should == "Unexpected url.  Should be in the format [ip:port]/films"
  end 
end

