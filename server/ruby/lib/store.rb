require 'dalli'
require 'showing'
require 'remote_persister'

class Store
  def initialize persister = RemotePersister.new
    @persister = persister
    @films = []
  end

  def reset
    puts "* Resetting films in store"
    @films = []
    @persister.reset
  end

  def add films
    puts "Adding films to store " + films.to_s
    @films += films
  end

  def contents
    @films
  end

  def persist
    @persister.save build_json 
  end
  
  def get_json
    json = @persister.retrieve
    puts "Cached json:" + json.to_s 
    json || build_json() 
  end

  def build_json
    puts "Films in store: " + @films.to_s
    films_json = @films.map {|film| film.to_json}
    '[' + films_json.join(',') + ']'
  end
end
