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
    @@channels.each {|channel| channel.films = []}
  end

  def self.begin_caching
    puts "Beginning to cache films for channels: " + @@channels.to_s
    add_films_to_cache
    puts "Caching complete" 
  end

  def self.add_films_to_cache
    loop do
      no_films_left = true
      @@channels.each do |channel|
        no_films_left_on_this_channel = add_from_channel? channel
        no_films_left = no_films_left && !no_films_left_on_this_channel
      end
      break if no_films_left
    end
  end

  def self.add_from_channel? channel
    next_batch = @@tv.get_films channel
    return false if next_batch.nil?
    channel.films += next_batch
    next_batch.each do |showing|
      Thread.new do
        rating = @@reviewer.review(showing.name)
        showing.rating = rating
        puts "  Updated showing to " + showing.to_s
      end
    end
    true
  end

  def get_films
    puts "Retrieving films from cache"
    @@channels[0].films
  end

  def get_channels
    @@channels
  end
end

