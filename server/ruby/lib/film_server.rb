require 'showing'
require 'film_reviewer'
require 'television'

class FilmServer
  attr_writer :days_to_search

  def initialize reviewer = FilmReviewer.new, tv = Television.new
    @reviewer = reviewer
    @tv = tv
    @days_to_search = 7
  end
  
  def handleGET(request, response)
    response.body = 
      if request.path != "/films"
        "Unexpected url.  Should be in the format [ip:port]/films"
      else
        days = request.query['days']
        films = @tv.get_films (days == nil ? @days_to_search : days.to_i)
        films_json = films.map {|film| film.to_json}
        '[' + films_json.join(', ') + ']'
      end
  end 
end
