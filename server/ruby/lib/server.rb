require 'webrick'

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    FilmServer.new.handleGET request response
  end 
end

server = WEBrick::HTTPServer.new( :Port => 1234 )
server.mount "/", MyServlet
trap("INT"){ server.shutdown }
server.start

