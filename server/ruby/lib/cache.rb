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
      add_films_to_cache
      puts "Caching complete" 
    end
  end

  def self.add_films_to_cache
    loop do
      next_batch = @tv.get_films
      break if next_batch.empty?
      @@showings += next_batch
      next_batch.each {|showing| showing.rating = @reviewer.review(showing.name) }
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

