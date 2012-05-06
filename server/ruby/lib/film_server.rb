require 'film'

class FilmServer
  def initialize reviewer, jsonifier
    @reviewer = reviewer
    @jsonifier = jsonifier
  end
  
  def do_GET(request, response)
    film_name = request.query['name']
    if film_name
      json = review film_name
      puts json
      response.body = json
    else
      response.body = nil
    end
  end 

  def review film_name
    rating = @reviewer.review film_name
    @jsonifier.convert(Film.new film_name, rating)
  end
end
