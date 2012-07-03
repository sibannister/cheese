require 'rubygems'
require 'imdb'

class FilmReviewer
  def review film_name
    puts "Requesting rating for " + film_name
    candidates = Imdb::Search.new(film_name).movies
    #titles = candidates.map {|movie| movie.title}
    #puts "Possible imdb matches for '" + film_name + "': " + titles.join(", ")

    imdb_film = find_best_match film_name, candidates
    #rating = imdb_film.rating if Showing.match_title? film_name, imdb_film.title
    puts "  Rating for " + film_name + " is " + imdb_film.rating.to_s
    [imdb_film.rating, imdb_film.poster]
  end

  def find_best_match film_name, candidates
    best_match = nil
    best_match_score = 0
    candidates.each do |candidate| 
      score = Showing.title_match_score(film_name, candidate.title)
      #alternative_title = candidate.also_known_as[0] if candidate.also_known_as.length > 0
      #puts candidate.title + " is also known as " + alternative_title

      if score > best_match_score
        best_match = candidate
        best_match_score = score
      end
    end

    best_match
  end
end
