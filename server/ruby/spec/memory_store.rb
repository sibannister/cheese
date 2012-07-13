class MemoryStore
  def initialize
    @entries = []
  end

  def add items
    puts "adding " + items.size.to_s + " films to cache"
    @entries += items
  end

  def persist
  end

  def get
    @entries
  end

  def get_json
    puts "constructing json for " + @entries.size.to_s + " films in cache"
    films_json = @entries.map {|film| film.to_json}
    '[' + films_json.join(', ') + ']'
  end
end

