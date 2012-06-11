require 'showing'
require 'film_reviewer'
require 'television'
require 'cache'

class FilmServer
  attr_writer :days_to_search

  def initialize cache = Cache.new
    @days_to_search = 7
    @cache = cache
  end
  
  def handleGET(request, response)
    response.body = 
      if request.path == "/films"
        films = @cache.get_films
        films_json = films.map {|film| film.to_json}
        '[' + films_json.join(', ') + ']'
      elsif request.path == "/channels"
        channels = @cache.get_channels
        channels_json = channels.map {|channel| channel.to_json}
        '[' + channels_json.join(', ') + ']'
      else
        "Unexpected url.  Should be in the format [ip:port]/films"
      end
  end 

  def add_ratings films
    films.each { |film| film.rating = @reviewer.review film.name }
  end
end
