require 'television' 
require 'channel'
require 'film_reviewer'

class Cache
  def self.build television = Television.new, reviewer = FilmReviewer.new, channels = [Channel.new('Film 4', 25409)], cache_duration_in_seconds = 10.days
    @@tv = television
    @@reviewer = reviewer
    @@channels = channels
    @@cache_duration_in_seconds = cache_duration_in_seconds

    reset
    add_films_to_cache
  end

  def self.reset
    @@films = []
    @@channels
  end

  def self.add_films_to_cache
    puts "BEGINNING TO CACHE " + (@@cache_duration_in_seconds / (60*60*24)).to_s + " days worth of films for channels: " + @@channels.to_s
    loop do
      add_from_channels
      break if @@tv.films_retrieved_up_to? Time.now + @@cache_duration_in_seconds
    end
    puts "CACHING COMPLETE" 
  end

  def self.add_from_channels
    next_batch = @@tv.get_films(@@channels, Time.now + @@cache_duration_in_seconds)
    puts 'Next batch of ' + next_batch.count.to_s + ' films being added'
    @@films += next_batch
    puts 'Kicking off review gathering on separate thread'
    next_batch.each do |showing|
      Thread.new do
        rating = @@reviewer.review(showing.name)
        showing.rating = rating
        puts "  Updated showing to " + showing.to_s
      end
    end
    puts 'Threads kicked off'
  end

  def get_films
    puts "Retrieving films from cache"
    @@films
  end
end

