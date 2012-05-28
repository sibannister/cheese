require 'soap_source'

describe SoapSource do
  it 'should retrieve some xml from the rovi service' do
    SoapSource.new.read(Time.now).should include('GridAiring')
  end
end
