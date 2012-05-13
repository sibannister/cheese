require 'imdb'

class FilmRepository
  def find film_name
    result = Imdb::Search.new(film_name)
    imdb_film = result.movies[0]
    film = Film.new film_name, imdb_film.rating
    return film if film.match_title imdb_film.title
  end
end
