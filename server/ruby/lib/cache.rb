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
      break if next_batch.nil?
      @@showings += next_batch
      next_batch.each do |showing|
        Thread.new do
          rating = @reviewer.review(showing.name)
          showing.rating = rating
          puts "*  Updated showing to " + showing.to_s + " using value " + rating.to_s
        end
      end
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

