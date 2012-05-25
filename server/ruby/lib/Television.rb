require 'fixnum'
require 'hpricot'
require 'film'
require 'film_service_failure'
require 'soap_source'
require 'rovi_source'

class Television
  def initialize rovi_source = RoviSource.new
    @rovi_source = rovi_source
  end

  def get_films
    start = Time.now
    films = []
    until start >= Time.now + 7.days
      batch = @rovi_source.get_films start
      films = films + batch.films
      start = batch.end_date
    end
    films
  end
end
