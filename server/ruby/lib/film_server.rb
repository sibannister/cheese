require 'showing'
require 'film_reviewer'
require 'television'
require 'cache'

class FilmServer
  attr_writer :days_to_search

  def initialize cache = Cache.new
    @days_to_search = 7
    @cache = cache
    cache.begin_caching
  end
  
  def handleGET(request, response)
    response.body = 
      if request.path != "/films"
        "Unexpected url.  Should be in the format [ip:port]/films"
      else
        days = request.query['days']
        films = @cache.get_films
        films_json = films.map {|film| film.to_json}
        '[' + films_json.join(', ') + ']'
      end
  end 

  def add_ratings films
    films.each { |film| film.rating = @reviewer.review film.name }
  end
end
