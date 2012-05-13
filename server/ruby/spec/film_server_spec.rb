require 'film_server'
require 'film_repository'
require 'net/http'

describe FilmServer do
  before :each do
    @repository = stub
    @film_server = FilmServer.new(@repository)
    @response = MockResponse.new
  end

  it 'should return json for known films' do
    film = Film.new('The Godfather', 2.3)
    @repository.stub(:find, 'The Godfather'){ film }
    handleGetRequest 'The Godfather'
    @response.body.should eq film.to_json
  end

  it 'should return nil for unknown films' do
    @repository.stub(:find, 'blah'){nil}
    handleGetRequest 'blah'
    @response.body.should be_nil
  end

  it 'should integrate with the film repository' do
    @film_server = FilmServer.new
    handleGetRequest 'blah'
  end
  
  def handleGetRequest film_name
    request = stub(:query => {'name' => film_name} )
    @film_server.handleGET request, @response
  end
end


class MockResponse
  attr_accessor :body
end
