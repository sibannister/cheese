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
    Dalli::Client.new 'mc5.ec2.northscale.net:11211', :username => 'app5077305%40heroku.com', :password => 'YvePBrvyZp3pPLs0'
  end
end
