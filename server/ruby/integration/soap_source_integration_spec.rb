require 'soap_source'
require 'fixnum'
require 'channel'

describe SoapSource do
  it 'should retrieve some xml from the rovi service' do
    film4 = Channel.new 'Film 4', 891296
    SoapSource.new.read(Time.now, film4).should include('GridAiring')
  end
end
