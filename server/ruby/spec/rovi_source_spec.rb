require 'rovi_source'
require 'timecop'

describe 'RoviSource' do
  let (:soap_source) { stub }
  let (:source) { RoviSource.new soap_source }

  before do
    Timecop.freeze
  end

  it 'should return no films from a nil soap packet' do
    soap_source.stub(:read).with(Time.now, 240).and_return nil
    source.get_films(Time.now).films.should be_empty
  end

  it 'should return no films from an empty soap packet' do
    soap_source.stub(:read).with(Time.now, 240).and_return ''
    source.get_films(Time.now).films.should be_empty
  end

  it 'should raise an error from a junk soap packet' do
    soap_source.stub(:read).with(Time.now, 240).and_return 'wibble'
    expect {source.get_films(Time.now)}.to raise_error(FilmServiceFailure)
  end

  it 'should extract a film from a soap response' do
    soap_response = File.read('rovi/get_grid_schedule_response.xml') 
    soap_source.stub(:read).with(Time.now, 240).and_return soap_response
    films = source.get_films(Time.now).films
    films.should have(2).items
    films.should include 
          Showing.new 'David and Bathsheba', 9.9, 
            Time.utc(2012, 5, 22, 10, 0, 0),
            Time.utc(2012, 5, 22, 12, 25, 0)
    films.should include 
          Showing.new 'White Feather', 9.9, 
            Time.utc(2012, 5, 22, 12, 25, 0),
            Time.utc(2012, 5, 22, 14, 30, 0)
  end

  it 'should return the end date of the films in the soap packet' do
    Timecop.freeze
    soap_response = File.read('rovi/get_grid_schedule_response.xml') 
    soap_source.stub(:read).with(Time.now, 240).and_return soap_response
    source.get_films(Time.now).end_date.should == Time.utc(2012, 5, 22, 14, 30, 0)
  end 

  it 'should return a end date 4 hours after the start when there are no films' do
    soap_source.stub(:read).with(Time.now, 240).and_return nil
    source.get_films(Time.now).end_date.should == Time.now + 240.minutes
  end

end

