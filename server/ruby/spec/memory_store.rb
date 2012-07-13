class MemoryStore
  def initialize
    @entries = {}
  end

  def add key, value
    @entries[key] = value
  end
  def get key
    @entries[key]
  end
end

