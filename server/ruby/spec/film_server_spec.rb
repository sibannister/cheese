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
    @repository.stub(:review, 'The Godfather'){2.3}
    handleGetRequest 'The Godfather'
    @response.body.should eq Film.new('The Godfather', 2.3).to_json
  end

  it 'should return nil for unknown films' do
    @repository.stub(:review, 'blah'){nil}
    handleGetRequest 'blah'
    @response.body.should be_nil
  end

  def handleGetRequest film_name
    request = stub(:query => {'name' => film_name} )
    @film_server.handleGET request, @response
  end
end


class MockResponse
  attr_accessor :body
end
