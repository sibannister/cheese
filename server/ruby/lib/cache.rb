require 'store'
require 'television' 
require 'channel'
require 'film_reviewer'

class Cache
  @store = nil

  def initialize television = Television.new, reviewer = FilmReviewer.new, store = Store.new, cache_duration_in_seconds = 10.days
    @tv = television
    @reviewer = reviewer
    @store = store
    @cache_duration_in_seconds = cache_duration_in_seconds
    @review_threads = []
  end

  def build 
    @store.reset
    add_films_to_cache
  end

  def add_films_to_cache
    puts "BEGINNING TO CACHE " + (@cache_duration_in_seconds / (60*60*24)).to_s + " days worth of films"
    loop do
      add_from_channels
      break if @tv.films_retrieved_up_to? Time.now + @cache_duration_in_seconds
    end
    puts "CACHING COMPLETE" 
    cache_everything
  end

  def cache_everything
    puts "Waiting for " + @review_threads.size.to_s + " review threads to complete before caching result"
    @review_threads.each do |thread| 
      thread.join
    end
    puts "Review threads complete.  Films json will now be cached in database"

    @store.persist
  end

  def add_from_channels
    next_batch = @tv.get_films(Time.now + @cache_duration_in_seconds)
    remove_duplicates next_batch
    puts 'Next batch of ' + next_batch.count.to_s + ' films being added'
    @store.add next_batch
    gather_ratings next_batch
  end

  def gather_ratings next_batch
    puts 'Kicking off review gathering on separate thread' + next_batch.size.to_s
    next_batch.each do |showing|
      puts "Creating thread for " + showing.to_s
      thread = Thread.new do
        rating, image = @reviewer.review(showing.name)
        showing.rating = rating
        showing.image = image
        puts "  Updated showing to " + showing.to_s
      end
      @review_threads << thread
    end
  end

  def remove_duplicates next_batch
    next_batch.delete_if { |film| @store.contents.any? { |film_in_cache| film_in_cache.name == film.name } }
  end

  def get_films
    puts "Retrieving films from cache"
    @store.get_json
  end

  def jsonify films
    films_json = films.map {|film| film.to_json}
    '[' + films_json.join(', ') + ']'
  end
end

