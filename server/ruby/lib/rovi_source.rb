require 'soap_source'
require 'unreliable_object_delegate'
require 'fixnum'
require 'hpricot'
require 'showing'
require 'film_service_failure'

class FilmBatch
  def initialize films, end_date
    @films = films
    @end_date = end_date
  end

  def films
    @films
  end

  def end_date
    @end_date
  end
end

class RoviSource
  def initialize soap_source = DummySoapSource.new
    @soap_source = UnreliableObjectDelegate.new soap_source, 4, 4
  end

  def get_films start_time, channel
    puts 'Requesting films starting at ' + start_time.to_s + " on " + channel.name
    soap = @soap_source.read start_time, channel
    return empty_batch(start_time) if soap.nil? || soap.empty? || has_no_programmes(soap)
    extract_films soap, channel
  end

  def empty_batch start_time
    FilmBatch.new [], start_time + 240.minutes
  end

  def has_no_programmes soap
    !soap.include?("GridAiring")
  end

  def extract_films soap, channel
    doc = Hpricot.XML(soap)
    films = (doc/"GridAiring")
    puts films.count.to_s + ' showings in soap'
    end_date = end_date films.last
    films.delete_if {|film| film['Category'] != 'Movie' }
    films = films.map {|film| Showing.new film['Title'], start_date(film), end_date(film), channel.name }
    puts '  Films in soap: ' + films.to_s
    FilmBatch.new films, end_date
  end 

  def start_date film
    Time.parse(film['AiringTime'])
  end

  def end_date film
    Time.parse(film['AiringTime']) + film['Duration'].to_i.minutes
  end
end

class DummySoapSource
  def read x, y
    File.read('rovi/get_grid_schedule_response.xml') 
  end
end
