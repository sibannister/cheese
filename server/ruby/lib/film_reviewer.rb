require 'rubygems'
require 'imdb'

class FilmReviewer
  def review film_name
    print "Requesting rating for " + film_name + "..."
    result = Imdb::Search.new(film_name)
    imdb_film = result.movies[0]
    puts imdb_film.rating.to_s
    imdb_film.rating if Showing.match_title? film_name, imdb_film.title
  end
end
