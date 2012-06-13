require 'film_server'
require 'film_reviewer'
require 'net/http'

describe FilmServer do
  it 'should handle the films url without crashing' do
    response = mock
    server = FilmServer.new
    
    response.should_receive(:body=)
    server.handleGET stub(:path => "/cache", :query => {"days" => 1}), response
    sleep 10

    response.should_receive(:body=)
    server.handleGET stub(:path => "/films"), response
  end
end
