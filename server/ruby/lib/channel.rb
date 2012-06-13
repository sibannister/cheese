class Channel
  attr_reader :name, :code

  def initialize name, code
    @name = name
    @code = code
  end

  def == other
    return false if other.nil?
    @name == other.name && @code == other.code 
  end

  def to_s
    @name.to_s + " (" + @code.to_s + ")"
  end
end
