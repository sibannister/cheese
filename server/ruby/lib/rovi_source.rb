require 'soap_source'
require 'soap_converter'
require 'unreliable_object_delegate'
require 'fixnum'
require 'hpricot'
require 'showing'
require 'showing_batch'
require 'channel_source'

class RoviSource
  MAX_ATTEMPTS_TO_CALL_ROVI = 4
  TIMEOUT_FOR_ROVI_CALL_S = 20
  SCHEDULE_REQUEST_DURATION_S = 4.hours

  def initialize soap_source = SoapSource.new, channels = ChannelSource.new
    @channels = channels
    @soap_source = UnreliableObjectDelegate.new soap_source, TIMEOUT_FOR_ROVI_CALL_S, MAX_ATTEMPTS_TO_CALL_ROVI
  end

  def get_showings start_time
    puts "Requesting showings starting at #{start_time}"
    soap = @soap_source.read start_time, @channels
    return empty_batch(start_time) if soap.nil? || soap.empty? || has_no_programmes(soap)

    showings = extract_showings soap
    batch start_time, showings
  end

  def empty_batch start_time
    batch start_time, []
  end

  def batch start_time, showings
    ShowingBatch.new showings, start_time + SCHEDULE_REQUEST_DURATION_S
  end

  def has_no_programmes soap
    !soap.include? "GridAiring"
  end

  def extract_showings soap
    doc = Hpricot.XML soap
    channels_xml = (doc/"GridChannel")
    
    showings = []
    channels_xml.each {|channel_xml| showings += parse_channel_xml channel_xml}
    
    puts "  Showings in soap: #{showings}"
    showings
  end

  def parse_channel_xml channel_xml
    channel = channel channel_xml
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
