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


puts "DB is " + ENV.keys.to_s# ['SHARED_DATABASE_URL'].to_s

server = WEBrick::HTTPServer.new( :Port => ARGV[0] )
server.mount "/", MyServlet
trap("INT"){ server.shutdown }
server.start

