class Channel
  attr_reader :name, :code
  attr_accessor :films

  def initialize name, code
    @name = name
    @code = code
    @films = []
  end

  def == other
    return false if other.nil?
    @name == other.name && @code == other.code && @films == other.films
  end

  def << film
    @films << film
    self
  end

  def to_s
    @name.to_s + " (" + @code.to_s + ") " + films.to_s
  end
end
