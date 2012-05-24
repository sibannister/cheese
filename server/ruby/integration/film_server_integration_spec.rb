require 'film_server'
require 'film_repository'
require 'net/http'

describe FilmServer do
  it 'should integrate with the film repository' do
    response = mock
    response.should_receive(:body=).with('{"name" : "The Godfather", "rating" : 9.2}')
    request = stub(:query => {'name' => 'The Godfather'}, :path => "/films" )
    FilmServer.new.handleGET request, response
  end

  it 'should handle the films url without crashing' do
    response = mock
    response.should_receive(:body=)
    request = stub(:query => {}, :path => "/films")
    FilmServer.new.handleGET request, response
  end
end
