require 'fixnum'
require 'hpricot'
require 'showing'
require 'film_service_failure'
require 'soap_source'
require 'rovi_source'

class Television
  def initialize rovi_source = RoviSource.new
    @rovi_source = rovi_source
    @next_batch_start_time = Time.now
  end

  def get_films 
    batch = @rovi_source.get_films @next_batch_start_time
    puts 'Batch end date is ' + batch.end_date.to_s
    @next_batch_start_time = batch.end_date
    batch.films
  end
end
