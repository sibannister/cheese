require 'showing'
require 'film_reviewer'
require 'television'

class FilmServer
  def initialize reviewer = FilmReviewer.new, tv = Television.new
    @reviewer = reviewer
    @tv = tv
  end
  
  def handleGET(request, response)
    response.body = 
      if request.path != "/films"
        "Unexpected url.  Should be in the format [ip:port]/films"
      else
        films = @tv.get_films
        films_json = films.map {|film| film.to_json}
        '[' + films_json.join(', ') + ']'
      end
  end 
end
