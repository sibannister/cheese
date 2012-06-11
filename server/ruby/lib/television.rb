require 'fixnum'
require 'hpricot'
require 'showing'
require 'film_service_failure'
require 'soap_source'
require 'rovi_source'

class Television
  def initialize rovi_source = RoviSource.new
    @rovi_source = rovi_source
    @next_batch_start_time = {}
  end

  def get_films channel, end_time
    return [] if start_time(channel) >= end_time
    batch = @rovi_source.get_films start_time(channel), channel
    puts 'Batch end date is ' + batch.end_date.to_s
    @next_batch_start_time[channel] = batch.end_date
    batch.films
  end

  def start_time channel
    start_time = @next_batch_start_time[channel]
    start_time.nil? ? Time.now : start_time
  end

  def films_retrieved_up_to? time
    @next_batch_start_time.values.all? {|end_date| end_date >= time}
  end
end
