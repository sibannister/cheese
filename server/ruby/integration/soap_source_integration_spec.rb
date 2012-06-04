require 'soap_source'

describe SoapSource do
  it 'should retrieve some xml from the rovi service' do
    SoapSource.new.read(Time.now, 240).should include('GridAiring')
  end
end
