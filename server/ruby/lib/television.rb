require 'rovi_source'

class Television
  def initialize rovi_source = RoviSource.new
    @rovi_source = rovi_source
    @next_batch_start_time = Time.now
  end

  def get_showings end_time
    return [] if @next_batch_start_time >= end_time
    batch = @rovi_source.get_showings @next_batch_start_time
    puts 'Batch end date is ' + batch.end_date.to_s
    @next_batch_start_time = batch.end_date
    batch.showings
  end

  def showings_retrieved_up_to? time
    @next_batch_start_time >= time
  end
end
