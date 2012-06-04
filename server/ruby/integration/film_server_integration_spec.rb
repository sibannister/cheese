require 'film_server'
require 'film_reviewer'
require 'net/http'

describe FilmServer do
  it 'should handle the films url without crashing' do
    response = mock
    response.should_receive(:body=)
    request = stub(:query => {}, :path => "/films")
    FilmServer.new.handleGET request, response
  end
end
