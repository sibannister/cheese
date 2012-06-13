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
    begin_caching
  end

  def self.reset
    @@channels.each {|channel| channel.films = []}
  end

  def self.begin_caching
    puts "Beginning to cache films for channels: " + @@channels.to_s
    add_films_to_cache
    puts "CACHING COMPLETE" 
  end

  def self.add_films_to_cache
    loop do
      puts 'Round of channels beginning'
      @@channels.each do |channel|
        add_from_channel channel
      end
      puts 'Round of channels completed'
      break if @@tv.films_retrieved_up_to? Time.now + @@cache_duration_in_seconds
    end
  end

  def self.add_from_channel channel
    next_batch = @@tv.get_films(channel, Time.now + @@cache_duration_in_seconds)
    puts 'Next batch of ' + next_batch.count.to_s + ' films being added to ' + channel.name
    channel.films += next_batch
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
    @@channels[0].films
  end

  def get_channels
    puts "Retrieving channels from cache"
    @@channels
  end
end

