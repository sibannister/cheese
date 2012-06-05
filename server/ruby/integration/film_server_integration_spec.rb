require 'film_server'
require 'film_reviewer'
require 'net/http'

describe FilmServer do
  it 'should handle the films url without crashing' do
    response = mock
    response.should_receive(:body=)
    request = stub(:query => {"days" => "1"}, :path => "/films")
    server = FilmServer.new
    server.days_to_search = 1
    server.handleGET request, response
  end
end
