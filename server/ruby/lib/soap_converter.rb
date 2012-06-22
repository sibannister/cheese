require 'showing'
require 'hpricot'
require 'time'
require 'fixnum'

class SoapConverter
  def convert xml, channel
    Showing.new xml['Title'], start_date(xml), end_date(xml), channel
  end

  def start_date xml
    Time.parse(xml['AiringTime'])
  end

  def end_date xml
    Time.parse(xml['AiringTime']) + xml['Duration'].to_i.minutes
  end
end
