class Store
  def initialize
    reset
  end

  def reset
    @@films = []
  end

  def add films
    @@films += films
  end

  def contents
    @@films
  end
end
