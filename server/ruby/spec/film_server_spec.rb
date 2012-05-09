require 'film_server'
require 'film_jsonifier'
require 'reviewer'
require 'net/http'

describe FilmServer do
  before :each do
    @reviewer = stub
    @jsonifier = stub
    @film_server = FilmServer.new(@reviewer, @jsonifier)
  end

  it 'should handle requests and responses' do
    @film_server.stub(:review, 'The Godfather') { '{some json}' }
    response = MockResponse.new
    request = stub(:query => {'name' => 'The Godfather'} )
    ##request.stub(:query){ {'name' => 'The Godfather'} }

    @film_server.handleGET request, response
    response.body.should eq "{some json}"
  end

  it 'should package films in json objects' do
    @reviewer.stub(:review, 'The Godfather'){2.3}
    @jsonifier.stub(:convert){'{json string}'}
    @film_server.review('The Godfather').should eq '{json string}'
  end

  it 'should return nil for unknown films' do
    @reviewer.stub(:review, 'blah'){nil}
    @film_server.review('blah').should be_nil
  end
end


class MockResponse
  attr_accessor :body
end
