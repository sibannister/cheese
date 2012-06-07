require 'television'
require 'film_reviewer'

class Cache
  def self.build television = Television.new, reviewer = FilmReviewer.new
    @tv = television
    @reviewer = reviewer
    reset
    begin_caching
  end

  def self.reset
    @@caching = false
    @@showings = []
  end

  def self.begin_caching
    if !@@caching
      @@caching = true
      puts "Beginning to cache films"
      @@showings = @tv.get_films 7
      @@showings.each {|showing| showing.rating = @reviewer.review(showing.name) }
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

