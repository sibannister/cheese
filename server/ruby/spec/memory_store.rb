class MemoryStore
  def reset
    @entries = []
  end

  def add items
    puts "adding " + items.size.to_s + " films to cache"
    @entries += items
  end

  def persist
    get_json
  end

  def contents
    @entries
  end

  def get_json
    @entries.to_json
  end
end

