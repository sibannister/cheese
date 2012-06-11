require 'television' 
require 'channel'
require 'film_reviewer'

class Cache
  def self.build television = Television.new, reviewer = FilmReviewer.new, channels = [Channel.new('Film 4', 891296)]
    @@tv = television
    @@reviewer = reviewer
    @@channels = channels
    reset
    begin_caching
  end

  def self.reset
    @@showings = []
    film4 = Channel.new('Film 4', 123)
  end

  def self.begin_caching
    puts "Beginning to cache films"
    add_films_to_cache
    puts "Caching complete" 
  end

  def self.add_films_to_cache
    loop do
      film4 = Channel.new 'Film 4', 891296
      next_batch = @@tv.get_films film4
      break if next_batch.nil?
      @@showings += next_batch
      next_batch.each do |showing|
        Thread.new do
          rating = @@reviewer.review(showing.name)
          showing.rating = rating
          puts "  Updated showing to " + showing.to_s
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

  def get_channels
    @@channels[0].films += @@showings
    @@channels
  end
end

