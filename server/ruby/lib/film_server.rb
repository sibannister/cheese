require 'db'
require 'showing'
require 'film_reviewer'
require 'television'
require 'presenter'
require 'fixnum'

class FilmServer
  attr_writer :days_to_search

  def initialize presenter = Presenter.new
    @days_to_search = 7
    @presenter = presenter
  end

  def build_cache days
    channels = read_channels
    tv = Television.new(RoviSource.new(SoapSource.new, channels))
    @presenter.build tv, FilmReviewer.new, days.days
  end

  def read_channels
    File.open("channels.txt").map {|line| read_channel(line)}
  end

  def read_channel line
    channel = Channel.new line.split(',')[0], line.split(',')[1].to_i
    puts channel
    channel
  end

  def handleGET request, response
    response.body = get_response_body request
  end 

  def get_response_body request
    begin
      if request.path == "/cache"
        days = request.query['days']
        build_cache(days.nil? ? 7 : days.to_i)
        "Initialised movie robot"
      end

      if request.path == "/films"
        films_json = @presenter.get_films
      elsif request.path == "/db"
        Database.new.get
      else
        "Unexpected url.  Should be in the format [ip:port]/films"
      end
    rescue => e
      "Error occured - " + e.message 
    end
  end

  def add_ratings films
    films.each { |film| film.rating = @reviewer.review film.name }
  end
end
