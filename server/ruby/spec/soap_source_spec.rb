require 'soap_source'

describe SoapSource do
  it 'should retrieve some xml from the rovi service' do
    SoapSource.new.read.should include('GridAiring')
  end
end
