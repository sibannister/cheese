require 'film'
require 'film_repository'

class FilmServer
  def initialize repository = FilmRepository.new
    @repository = repository
  end
  
  def handleGET(request, response)
    response.body = 
      if request.path != "/films"
        "Unexpected url.  Should be in the format [ip:port]/films?name=[title]"
      elsif request.query['name']
        review request.query['name']
      else
        nil
      end
  end 

  def review film_name
    film = @repository.find film_name
    film == nil ? nil : film.to_json
  end
end
