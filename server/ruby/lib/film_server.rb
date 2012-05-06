require 'film'
require 'reviewer'
require 'film_jsonifier'

class FilmServer
  def initialize reviewer = Reviewer.new, jsonifier = FilmJsonifier.new
    @reviewer = reviewer
    @jsonifier = jsonifier
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
    rating = @reviewer.review film_name
    rating == nil ? nil : @jsonifier.convert(Film.new film_name, rating)
  end
end
