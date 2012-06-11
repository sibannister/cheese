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
  end

  def self.begin_caching
    puts "Beginning to cache films"
    add_films_to_cache
    puts "Caching complete" 
  end

  def self.add_films_to_cache
    loop do
      no_films_left = true
      @@channels.each do |channel|
        no_films_left = no_films_left && !(add_from_channel? channel)
      end
      break if no_films_left
    end
  end

  def self.add_from_channel? channel
    puts "Looking for films on channel " + channel.name
    next_batch = @@tv.get_films channel
    return false if next_batch.nil?
    @@showings += next_batch
    next_batch.each do |showing|
      Thread.new do
        rating = @@reviewer.review(showing.name)
        showing.rating = rating
        puts "  Updated showing to " + showing.to_s
      end
    end
    true
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

