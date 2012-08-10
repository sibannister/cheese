require 'dalli'
require 'showing'

class Store
  def reset
    @@films = []
    cache.delete('json')
  end

  def add films
    @@films += films
  end

  def contents
    @@films
  end

  def persist
    cache.set('json', build_json())
  end
  
  def get_json
    json = cache.get 'json'
    puts "Cached json:" + json.to_s 
    json || build_json() 
  end

  def build_json
    films_json = @@films.map {|film| film.to_json}
    '[' + films_json.join(', ') + ']'
  end

  def cache
    Dalli::Client.new('localhost:11211')
  end
end
