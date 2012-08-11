require 'rubygems'
require 'imdb'

class FilmReviewer
  def review film_name
    puts "Requesting rating for " + film_name
    candidates = Imdb::Search.new(film_name).movies

    imdb_film = find_best_match film_name, candidates
    puts "  Rating for " + film_name + " is " + imdb_film.rating.to_s
    [imdb_film.rating, imdb_film.poster]
  end

  def find_best_match film_name, candidates
    best_match = nil
    best_match_score = 0
    candidates.each do |candidate| 
      score = Showing.title_match_score(film_name, candidate.title)

      if score > best_match_score
        best_match = candidate
        best_match_score = score
      end
    end

    best_match
  end
end
