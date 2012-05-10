class Film
  attr_reader :name, :rating

  def initialize name, rating
    @name = name
    @rating = rating
  end

  def to_json
    '{"name" : "' + name + '", "rating" : ' + rating.to_s + '}'
  end
end
