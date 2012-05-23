require 'television'
require 'film_service_failure'

describe Television do
  let(:soap_source) { stub }
  let(:tv) { Television.new soap_source }

  it 'should return no films from a nil soap packet' do
    soap_source.stub(:read).and_return nil
    tv.get_films.should be_empty
  end

  it 'should return no films from an empty soap packet' do
    soap_source.stub(:read).and_return ''
    tv.get_films.should be_empty
  end

  it 'should raise an error from a junk soap packet' do
    soap_source.stub(:read).and_return 'wibble'
    expect {tv.get_films}.to raise_error(FilmServiceFailure)
  end

  it 'should extract a film from a soap response' do
    soap_response = File.read('rovi/get_grid_schedule_response.xml') 
    soap_source.stub(:read).and_return soap_response
    films = tv.get_films
    films.should have(2).items
    films.should include(Film.new 'David and Bathsheba', 9.9)
    films.should include Film.new 'White Feather', 9.9
  end
  
end
