require 'timecop'
require 'fixnum'
require 'television'
require 'film_service_failure'
require 'channel'

describe Television do
  let(:rovi_source) { stub }
  let(:tv) { Television.new rovi_source }
  
  before do
    Timecop.freeze
    @now = Time.now
  end

  it 'should not attempt to retrieve any films if it has passed the required end time' do
    rovi_source.should_receive(:get_films).with(@now).and_return film_batch(@now + 4.hours, 3)
    tv.get_films(@now + 2.hours).should have(3).items
    tv.get_films(@now + 2.hours).should be_empty
  end
  
  it 'should retrieve films from rovi' do
    rovi_source.should_receive(:get_films).with(@now).and_return film_batch(@now + 4.hours, 3)
    tv.get_films(@now + 1.days).should have(3).items
  end

  it 'should know how far into the future it has retrieved films' do
    rovi_source.should_receive(:get_films).with(@now).and_return film_batch(@now + 4.hours, 3)
    tv.get_films(@now + 1.days)
    tv.films_retrieved_up_to?(@now).should be_true 
    tv.films_retrieved_up_to?(@now + 4.hours).should be_true 
    tv.films_retrieved_up_to?(@now + 5.hours).should be_false
  end
  
  it 'should begin retrieving from the point where it left off' do
    rovi_source.should_receive(:get_films).with(@now).and_return film_batch(@now + 4.hours, 3)
    rovi_source.should_receive(:get_films).with(@now + 4.hours).and_return film_batch(@now + 8.hours, 1)
    tv.get_films(@now + 1.days).should have(3).items
    tv.get_films(@now + 1.days).should have(1).items
  end

  it 'should integrate with rovi source' do
    soap_source = stub(:read => nil)
    tv = Television.new(RoviSource.new soap_source, [])
    tv.get_films(@now + 4.days)
  end

  def film_batch end_date, number_of_films
    film = Showing.new 'Birdemic', @now, @now, 'ITV'
    stub(:end_date => end_date, :films => [film] * number_of_films)
  end
end
