require 'film_server'
require 'film_repository'
require 'net/http'

describe FilmServer do
  let (:repository) { stub }
  let (:tv) { stub }
  let (:film_server) { FilmServer.new(repository, tv) }
  let (:response) { MockResponse.new }

  it 'should return a list of films if no name parameter specified' do
    request = stub(:query => {}, :path => "/films" )
    film1 = Film.new('The Godfather', 2.3)
    film2 = Film.new('Birdemic', 2.3)
    tv.stub(:get_films => [film1, film2])
    film_server.handleGET request, response
    response.body.should eq '[' + film1.to_json + ', ' + film2.to_json + ']'
  end

  it 'should ignore requests which do not start with the "/films" path' do
    request = stub(:query => {'name' => 'The Godfather'}, :path => "/wibble" )
    film_server.handleGET request, response
    response.body.should eq "Unexpected url.  Should be in the format [ip:port]/films"
  end 

  it 'should return json for known films' do
    film = Film.new('The Godfather', 2.3)
    repository.stub(:find, 'The Godfather'){ film }
    handleGetRequest 'The Godfather'
    response.body.should eq film.to_json
  end

  it 'should return nil for unknown films' do
    repository.stub(:find, 'blah'){nil}
    handleGetRequest 'blah'
    response.body.should be_nil
  end
  
  def handleGetRequest film_name
    request = stub(:query => {'name' => film_name}, :path => "/films" )
    film_server.handleGET request, response
  end
end


class MockResponse
  attr_accessor :body
end
