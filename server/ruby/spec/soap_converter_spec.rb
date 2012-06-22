require 'soap_converter'
require 'hpricot'

describe SoapConverter do
  it 'should convert a soap film into a showing' do
    soap = File.read('rovi/film.xml') 
    film_xml = (Hpricot.XML(soap)/"GridAiring")[0]

    showing = SoapConverter.new.convert film_xml, 'Film 4'
    showing.name.should == 'White Feather'
    showing.start_date.should == Time.utc(2012, 5, 22, 12, 25, 0)
    showing.end_date.should == Time.utc(2012, 5, 22, 14, 30, 0)
    showing.channel.should == 'Film 4'
    showing.image = 'some url'
  end
end
