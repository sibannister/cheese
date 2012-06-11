require 'showing'
require 'film_reviewer'
require 'television'
require 'cache'
require 'fixnum'

class FilmServer
  attr_writer :days_to_search

  def self.on_server_startup
    channels = read_channels
    Thread.new { Cache.build Television.new, FilmReviewer.new, channels, 1.days }
  end

  def self.read_channels
    File.open("channels.txt").map {|line| read_channel(line)}
  end

  def self.read_channel line
    channel = Channel.new line.split(',')[0], line.split(',')[1].to_i
    puts channel
    channel
  end

  def initialize cache = Cache.new
    @days_to_search = 7
    @cache = cache
  end

  def handleGET(request, response)
    response.body = 
      if request.path == "/films"
        films = @cache.get_films
        films_json = films.map {|film| film.to_json}
        '[' + films_json.join(', ') + ']'
      elsif request.path == "/channels"
        channels = @cache.get_channels
        channels_json = channels.map {|channel| channel.to_json}
        '[' + channels_json.join(', ') + ']'
      else
        "Unexpected url.  Should be in the format [ip:port]/films"
      end
  end 

  def add_ratings films
    films.each { |film| film.rating = @reviewer.review film.name }
  end
end
