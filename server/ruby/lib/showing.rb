class Showing
  include Comparable

  attr_reader :name, :start_date, :end_date, :channel
  attr_accessor :rating

  def ==(other)
    return false if other.nil?
    @name == other.name && @rating ==  other.rating && @channel == other.channel && @end_date == other.end_date && @start_date == other.start_date
  end

  def initialize name, start_date, end_date, channel, rating = 0
    @name = name
    @start_date = start_date
    @end_date = end_date
    @rating = rating
    @channel = channel
  end

  def self.match_title? actual_title, candidate_title
    candidate_title.upcase.start_with? actual_title.upcase
  end

  def to_json
    '{"name" : "' + name + '", "rating" : ' + rating.to_s + ', "channel" : "' + @channel + '", "start" : "' + @start_date.strftime('%Y-%m-%d %H:%M') + '"}'
  end

  def to_s
    name + " (" + @channel + " from " + @start_date.strftime('%d/%m %H:%M') + " to " + @end_date.strftime('%H:%M') + ") " + rating.to_s + "/10"
  end
end
