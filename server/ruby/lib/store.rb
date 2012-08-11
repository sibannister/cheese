require 'dalli'
require 'showing'
require 'remote_persister'

class Store
  def initialize persister = RemotePersister.new
    @persister = persister
    @showings = []
  end

  def reset
    puts "* Resetting showings in store"
    @showings = []
    @persister.reset
  end

  def add showings
    puts "Adding showings to store #{showings}"
    @showings += showings
  end

  def contents
    @showings
  end

  def persist
    puts "Persisting #{@showings.size} showings"
    @persister.save @showings.to_json
  end
  
  def get_json
    json = @persister.retrieve
    puts "Cached json: #{json}"
    json || @showings.to_json
  end
end
