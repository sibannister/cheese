require 'fixnum'
require 'hpricot'
require 'showing'
require 'film_service_failure'
require 'soap_source'
require 'rovi_source'

class Television
  def initialize rovi_source = RoviSource.new
    @rovi_source = rovi_source
  end

  def get_films days_to_search
    start = Time.now
    films = []
    until start >= Time.now + days_to_search.days
      batch = @rovi_source.get_films start
      films = films + batch.films
      puts 'Batch end date is ' + batch.end_date.to_s
      start = batch.end_date
    end
    films
  end
end
