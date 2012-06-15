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

  def get_films start_time, channels
    puts 'Requesting films starting at ' + start_time.to_s
    soap = @soap_source.read start_time, channels
    return empty_batch(start_time) if soap.nil? || soap.empty? || has_no_programmes(soap)

    films = extract_films soap, channels
    FilmBatch.new films, start_time + 4.hours
  end

  def empty_batch start_time
    FilmBatch.new [], start_time + 240.minutes
  end

  def has_no_programmes soap
    !soap.include?("GridAiring")
  end

  def extract_films soap, channels
    doc = Hpricot.XML(soap)
    channels_xml = (doc/"gridchannel")
    
    films = []
    channels_xml.each {|channel_xml| films += parse_channel_xml channel_xml, channels}
    
    puts '  Films in soap: ' + films.to_s
    films
  end

  def parse_channel_xml channel_xml, channels
    puts 'Soap contains films for channel ' + channel_xml['sourceid']

    films = (channel_xml/"GridAiring")
    puts films.count.to_s + ' showings in soap'
    films.delete_if {|film| film['Category'] != 'Movie' }
    films.map {|film| Showing.new film['Title'], start_date(film), end_date(film), channel(channel_xml, channels) }
  end 

  def channel channel_xml, channels
    channels.find {|channel| channel.code.to_s == channel_xml['sourceid']}.name
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
