require 'store'
require 'television' 
require 'channel'
require 'film_reviewer'

class Presenter
  def initialize television = Television.new, reviewer = FilmReviewer.new, store = Store.new
    @tv = television
    @reviewer = reviewer
    @store = store
    @review_threads = []
  end

  def build_cache cache_duration_in_seconds
    @store.reset
    @cache_duration_in_seconds = cache_duration_in_seconds
    add_showings_to_cache
  end

  def add_showings_to_cache
    puts "BEGINNING TO CACHE " + (@cache_duration_in_seconds / (60*60*24)).to_s + " days worth of showings"
    loop do
      add_from_channels
      break if @tv.showings_retrieved_up_to? Time.now + @cache_duration_in_seconds
    end
    puts "CACHING COMPLETE" 
    store_result
  end

  def store_result
    puts "Waiting for " + @review_threads.size.to_s + " review threads to complete before caching result"
    @review_threads.each { |thread| thread.join }
    puts "* Review threads complete.  showings json will now be cached"
    @store.persist
  end

  def add_from_channels
    next_batch = @tv.get_showings Time.now + @cache_duration_in_seconds
    remove_duplicates next_batch
    puts 'Next batch of ' + next_batch.count.to_s + ' showings being added'
    @store.add next_batch
    gather_ratings next_batch
  end

  def gather_ratings next_batch
    puts 'Kicking off review gathering for ' + next_batch.size.to_s + ' films on separate thread'
    next_batch.each do |showing|
      puts "Creating thread for " + showing.to_s
      thread = Thread.new { review showing }
      @review_threads << thread
    end
  end

  def review showing
    rating, image = @reviewer.review(showing.name)
    showing.rating = rating
    showing.image = image
    puts "  Updated showing to " + showing.to_s
  end

  def remove_duplicates next_batch
    next_batch.delete_if { |showing| @store.contents.any? { |showing_in_cache| showing_in_cache.name == showing.name } }
  end

  def get_showings
    puts "Retrieving showings from cache"
    @store.get_json
  end
end

