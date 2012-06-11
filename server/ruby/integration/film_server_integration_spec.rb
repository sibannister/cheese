require 'film_server'
require 'film_reviewer'
require 'net/http'

describe FilmServer do
  it 'should handle the films url without crashing' do
    FilmServer.on_server_startup
    sleep 10

    response = mock
    response.should_receive(:body=)
    request = stub(:path => "/channels")
    server = FilmServer.new
    server.handleGET request, response
  end
end
