require 'rubygems'
require 'imdb'

class FilmReviewer
  def review film_name
    puts "Requesting rating for " + film_name
    result = Imdb::Search.new(film_name)
    imdb_film = result.movies[0]
    #rating = imdb_film.rating if Showing.match_title? film_name, imdb_film.title
    #puts "COULD NOT FIND GOOD ENOUGH MATCH FOR " + film_name + " closest match was " + imdb_film.title if rating.nil?
    puts "  Rating for " + film_name + " is " + imdb_film.rating.to_s
    imdb_film.rating
  end
end
