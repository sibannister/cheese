require 'json'
require 'amatch'
include Amatch

class Showing
  include Comparable

  attr_reader :name, :start_date, :end_date, :channel
  attr_accessor :rating, :image

  def initialize name, start_date, end_date, channel, image_url = nil, rating = 0
    @name = name
    @start_date = start_date
    @end_date = end_date
    @rating = rating
    @channel = channel
    @image = image_url
  end

  def to_json
    to_hash.to_json.to_s
  end

  def to_hash
    { :name => @name,
      :rating => @rating || 0,
      :channel => @channel,
      :start => @start_date.strftime('%Y-%m-%d %H:%M'),
      :end => @end_date.strftime('%Y-%m-%d %H:%M'),
      :image => @image }
  end

  def ==(other)
    return false if other.nil?
    @name == other.name &&
         @rating ==  other.rating &&
         @channel == other.channel &&
         @end_date == other.end_date &&
         @start_date == other.start_date &&
         @image == other.image
  end

  def to_s
    name + " (" + @channel + " from " + @start_date.strftime('%d/%m %H:%M') + " to " + @end_date.strftime('%H:%M') + ") " + rating.to_s + "/10 " + @image.to_s
  end
end
