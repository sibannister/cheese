require 'film'
require 'film_repository'
require 'television'

class FilmServer
  def initialize repository = FilmRepository.new, tv = Television.new
    @repository = repository
    @tv = tv
  end
  
  def handleGET(request, response)
    response.body = 
      if request.path != "/films"
        "Unexpected url.  Should be in the format [ip:port]/films"
      elsif request.query['name']
        review request.query['name']
      else
        films = @tv.get_films
        '[' + films[0].to_json + ', ' + films[1].to_json + ']'
      end
  end 

  def review film_name
    film = @repository.find film_name
    film == nil ? nil : film.to_json
  end
end
