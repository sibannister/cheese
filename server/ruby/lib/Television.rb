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
    until start >= Time.now + 1.days
      batch = @rovi_source.get_films start
      films = films + batch.films
      puts 'Batch end date is ' + batch.end_date.to_s
      start = batch.end_date
    end
    puts 'FIlms retrieved' + films.to_s
    films
  end
end
