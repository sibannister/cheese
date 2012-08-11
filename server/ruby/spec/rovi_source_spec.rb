require 'showing'
require 'rovi_source'
require 'timecop'
require 'channel'

describe 'RoviSource' do
  let (:channels) { [Channel.new('Film 4', 25409), Channel.new('BBC 1', 24872)]}
  let (:soap_source) { stub }
  let (:source) { RoviSource.new soap_source, channels }

  before do
    Timecop.freeze
  end

  it 'should pass the channel through to the soap source' do
    soap_source.should_receive(:read).with Time.now, channels
    source.get_showings Time.now
  end
  
  it 'should return no showings from a nil soap packet' do
    soap_source.stub(:read).with(Time.now, channels).and_return nil
    source.get_showings(Time.now).end_date.should == Time.now + 4.hours
  end

  it 'should return no showings from an empty soap packet' do
    soap_source.stub(:read).with(Time.now, channels).and_return ''
    source.get_showings(Time.now).end_date.should == Time.now + 4.hours
  end

  it 'should return no showings if there were no programmes in the soap packet' do
    soap_source.stub(:read).with(Time.now, channels).and_return 'wibble'
    source.get_showings(Time.now).end_date.should == Time.now + 4.hours
  end

  it 'should extract a showing from a soap response' do
    soap_response = File.read 'rovi/get_grid_schedule_response.xml'
    soap_source.stub(:read).with(Time.now, channels).and_return soap_response
    showings = source.get_showings(Time.now).showings
    showings.should have(2).items
    showings[0].should ==
          Showing.new('David and Bathsheba', 
            Time.utc(2012, 5, 22, 10, 0, 0),
            Time.utc(2012, 5, 22, 12, 25, 0),
            'Film 4')
    showings[1].should ==
          Showing.new('White Feather', 
            Time.utc(2012, 5, 22, 12, 25, 0),
            Time.utc(2012, 5, 22, 14, 30, 0),
            'BBC 1')
  end

  it 'should return the end date 4 hours after the start reqest time' do
    soap_response = File.read 'rovi/get_grid_schedule_response.xml'
    soap_source.stub(:read).with(Time.now, channels).and_return soap_response
    source.get_showings(Time.now).end_date.should == Time.now + 4.hours
  end 

  it 'should return a end date 4 hours after the start reuest time when there are no showings' do
    soap_response = File.read 'rovi/get_grid_schedule_response_no_films.xml'
    soap_source.stub(:read).with(Time.now, channels).and_return soap_response
    source.get_showings(Time.now).end_date.should == Time.now + 4.hours
  end
  
  it 'should integrate with the channel source' do
    soap_source.stub(:read).and_return nil
    rovi = RoviSource.new soap_source
    rovi.get_showings Time.now
  end
end

