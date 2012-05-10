require 'film'
require 'film_repository'

class FilmServer
  def initialize repository = FilmRepository.new
    @repository = repository
  end
  
  def handleGET(request, response)
    film_name = request.query['name']
    if film_name
      json = review film_name
      response.body = json
    else
      response.body = nil
    end
  end 

  def review film_name
    rating = @repository.review film_name
    rating == nil ? nil : Film.new(film_name, rating).to_json
  end
end
