require 'television'
require 'film_reviewer'

class Cache
  
  def initialize television = Television.new, reviewer = FilmReviewer.new
    if !defined?(@@caching)
      reset
    end
    @tv = television
    @reviewer = reviewer
  end

  def reset
    @@caching = false
    @@showings = []
  end

  def begin_caching
    if !@@caching
      @@caching = true
      puts "Beginning to cache films"
      @@showings = @tv.get_films 1
      #@@showings.each {|showing| showing.rating = @reviewer.review(showing.name) }
      puts "Caching complete" 
    end
  end

  def << showing
    @@showings << showing
    self
  end

  def get_films
    puts "Retrieving films from cache"

    @@showings
  end
end

