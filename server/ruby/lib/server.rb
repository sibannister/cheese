require 'webrick'
require 'film_server'

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    puts 'Request received'
    FilmServer.new.handleGET request, response
    response.status = 200
    response.content_type = "text/plain"
  end 
end

server = WEBrick::HTTPServer.new( :Port => ARGV[0] )
server.mount "/", MyServlet
trap("INT"){ server.shutdown }
channels = [ Channel.new('BBC 1', 24872) ]
Thread.new { Cache.build Television.new, FilmReviewer.new, channels }
server.start

