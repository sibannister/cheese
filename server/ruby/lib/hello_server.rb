require 'webrick'

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    response.status = 200
    response.content_type = "text/plain"

    callee = 'Anonmyous (use ?name=your_name to get a perosnalised greeting)...'
    if request.query['name']
      callee = request.query['name']
    end

    response.body = "Hello " + callee
  end 
end

server = WEBrick::HTTPServer.new( :Port => 1234 )
server.mount "/", MyServlet
trap("INT"){ server.shutdown }
server.start

