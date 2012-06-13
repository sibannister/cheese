require 'film_server'
require 'film_reviewer'
require 'net/http'

describe FilmServer do
  it 'should handle the films url without crashing' do
    FilmServer.build_cache 2
    sleep 10

    response = mock
    response.should_receive(:body=)
    request = stub(:path => "/channels")
    server = FilmServer.new
    server.handleGET request, response
  end
end
