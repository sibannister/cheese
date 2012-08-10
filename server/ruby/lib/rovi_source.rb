require 'soap_source'
require 'soap_converter'
require 'unreliable_object_delegate'
require 'fixnum'
require 'hpricot'
require 'showing'
require 'film_service_failure'
require 'showing_batch'

class RoviSource
  def initialize soap_source = SoapSource.new, channels = []
    @channels = channels
    @soap_source = UnreliableObjectDelegate.new soap_source, 30, 4
  end

  def get_showings start_time
    puts 'Requesting showings starting at ' + start_time.to_s
    soap = @soap_source.read start_time, @channels
    return empty_batch(start_time) if soap.nil? || soap.empty? || has_no_programmes(soap)

    showings = extract_showings soap
    ShowingBatch.new showings, start_time + 4.hours
  end

  def empty_batch start_time
    ShowingBatch.new [], start_time + 240.minutes
  end

  def has_no_programmes soap
    !soap.include?("GridAiring")
  end

  def extract_showings soap
    doc = Hpricot.XML(soap)
    channels_xml = (doc/"GridChannel")
    
    showings = []
    channels_xml.each {|channel_xml| showings += parse_channel_xml channel_xml}
    
    puts '  showings in soap: ' + showings.to_s
    showings
  end

  def parse_channel_xml channel_xml
    channel = channel(channel_xml)
    showings = (channel_xml/"GridAiring")
    showings.delete_if {|showing| showing['Category'] != 'Movie' }
    showings.map {|showing| SoapConverter.new.convert showing, channel}
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
