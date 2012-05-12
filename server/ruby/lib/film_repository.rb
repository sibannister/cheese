require 'imdb'

class FilmRepository
  def find film
    result = Imdb::Search.new(film)
    film = result.movies[0]
    film.rating
  end
end
