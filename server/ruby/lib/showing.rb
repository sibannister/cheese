class Showing
  include Comparable

  attr_reader :name, :rating, :start_date, :end_date

  def ==(other)
    return false if other.nil?
    @name == other.name && @rating ==  other.rating && @end_date == other.end_date && @start_date == other.start_date
  end

  def initialize name, rating, start_date, end_date 
    @name = name
    @rating = rating
    @start_date = start_date
    @end_date = end_date
  end

  def self.match_title? actual_title, candidate_title
    candidate_title.upcase.start_with? actual_title.upcase
  end

  def to_json
    '{"name" : "' + name + '", "rating" : ' + rating.to_s + '}'
  end
end
