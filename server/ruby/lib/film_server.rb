require 'db'
require 'showing'
require 'film_reviewer'
require 'television'
require 'presenter'
require 'fixnum'

class FilmServer
  attr_writer :days_to_search

  def initialize presenter = Presenter.new
    @presenter = presenter
  end

  def read_channels
    File.open("channels.txt").map {|line| read_channel(line)}
  end

  def read_channel line
    Channel.new line.split(',')[0], line.split(',')[1].to_i
  end

  def handleGET request, response
    response.body = get_response_body request
  end 

  def get_response_body request
    if request.path == "/cache"
      days = request.query['days']
      days = days.nil? ? 7 : days.to_i
      @presenter.build_cache days.days
    elsif request.path == "/films"
      @presenter.get_showings
    elsif request.path == "/db"
      Database.new.get
    else
      "Unexpected url.  Should be in the format [ip:port]/films or [ip:port]/cache?days=x"
    end
  end
end
