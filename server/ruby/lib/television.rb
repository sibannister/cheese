require 'rovi_source'

class Television
  def initialize rovi_source = RoviSource.new, end_time = Time.now
    @rovi_source = rovi_source
    reset end_time
  end

  def reset end_time
    @end_time = end_time
    @next_batch_start_time = Time.now
  end

  def get_next 
    return [] if all_showings_retrieved?
    batch = @rovi_source.get_showings @next_batch_start_time
    puts "Batch end date is #{batch.end_date}"
    @next_batch_start_time = batch.end_date
    batch.showings
  end

  def all_showings_retrieved?
    @next_batch_start_time >= @end_time
  end
end
