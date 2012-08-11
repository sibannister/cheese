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
