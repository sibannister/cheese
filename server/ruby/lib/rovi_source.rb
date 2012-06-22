require 'soap_source'
require 'soap_converter'
require 'unreliable_object_delegate'
require 'fixnum'
require 'hpricot'
require 'showing'
require 'film_service_failure'
require 'film_batch'

class RoviSource
  def initialize soap_source, channels
    @channels = channels
    @soap_source = UnreliableObjectDelegate.new soap_source, 30, 4
  end

  def get_films start_time
    puts 'Requesting films starting at ' + start_time.to_s
    soap = @soap_source.read start_time, @channels
    return empty_batch(start_time) if soap.nil? || soap.empty? || has_no_programmes(soap)

    films = extract_films soap
    FilmBatch.new films, start_time + 4.hours
  end

  def empty_batch start_time
    FilmBatch.new [], start_time + 240.minutes
  end

  def has_no_programmes soap
    !soap.include?("GridAiring")
  end

  def extract_films soap
    doc = Hpricot.XML(soap)
    channels_xml = (doc/"GridChannel")
    
    films = []
    channels_xml.each {|channel_xml| films += parse_channel_xml channel_xml}
    
    puts '  Films in soap: ' + films.to_s
    films
  end

  def parse_channel_xml channel_xml
    channel = channel(channel_xml)
    films = (channel_xml/"GridAiring")
    films.delete_if {|film| film['Category'] != 'Movie' }
    films.map {|film| SoapConverter.new.convert film, channel}
  end 

  def channel channel_xml
    @channels.find {|channel| channel.code.to_s == channel_xml['SourceId']}.name
  end
end

class DummySoapSource
  def read x
    File.read('rovi/get_grid_schedule_response.xml') 
  end
end
