class Film
  include Comparable

  attr_reader :name, :rating

  def <=>(other)
    @name <=> other.name && @rating <=> other.rating
  end

  def initialize name, rating
    @name = name
    @rating = rating
  end

  def match_title? candidate_title
    candidate_title.upcase.start_with? @name.upcase
  end

  def to_json
    '{"name" : "' + name + '", "rating" : ' + rating.to_s + '}'
  end
end
