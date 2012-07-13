require 'television' 
require 'channel'
require 'film_reviewer'

class Cache
 
  def self.store= store
    @@store = store
  end

  def self.database= database
    @@database = database
  end


  def self.build television = Television.new, reviewer = FilmReviewer.new, cache_duration_in_seconds = 10.days
    @@tv = television
    @@reviewer = reviewer
    @@cache_duration_in_seconds = cache_duration_in_seconds

    @@store.reset
    add_films_to_cache
  end

  def self.add_films_to_cache
    puts "BEGINNING TO CACHE " + (@@cache_duration_in_seconds / (60*60*24)).to_s + " days worth of films"
    loop do
      add_from_channels
      break if @@tv.films_retrieved_up_to? Time.now + @@cache_duration_in_seconds
    end
    puts "CACHING COMPLETE" 
  end

  def self.add_from_channels
    next_batch = @@tv.get_films(Time.now + @@cache_duration_in_seconds)
    puts 'Next batch of ' + next_batch.count.to_s + ' films being added'
    @@store.add next_batch
    gather_ratings next_batch
  end

  def self.gather_ratings next_batch
    puts 'Kicking off review gathering on separate thread'
    next_batch.each do |showing|
      Thread.new do
        rating, image = @@reviewer.review(showing.name)
        showing.rating = rating
        showing.image = image
        puts "  Updated showing to " + showing.to_s
        add_to_cache showing
      end
    end
    puts 'Threads kicked off'
  end

  #def self.remove_duplicates next_batch
    #next_batch.delete_if { |film| @@films.any? { |film_in_cache| film_in_cache.name == film.name } }
  #end

  def get_films
    puts "Retrieving films from cache"
    jsonify @@store.contents
  end

  def jsonify films
    films_json = films.map {|film| film.to_json}
    '[' + films_json.join(', ') + ']'
  end
end

