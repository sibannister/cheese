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
    @film4 = Channel.new 'Film 4', 123
  end

  it 'should retrieve films from rovi' do
    now = Time.now
    rovi_source.should_receive(:get_films).with(now, @film4).and_return film_batch(now + 4.hours, 3)
    tv.get_films(@film4).should have(3).items
  end

  it 'should begin retrieving from the point where it left off' do
    now = Time.now
    rovi_source.should_receive(:get_films).with(now, @film4).and_return film_batch(now + 4.hours, 3)
    rovi_source.should_receive(:get_films).with(now + 4.hours, @film4).and_return film_batch(now + 8.hours, 1)
    tv.get_films(@film4).should have(3).items
    tv.get_films(@film4).should have(1).items
  end

  it 'should remember where each different channel left off' do
    gay_rabbit = Channel.new 'Gay Rabbit', 456
    now = Time.now
    rovi_source.should_receive(:get_films).with(now, @film4).and_return film_batch(now + 4.hours, 3)
    rovi_source.should_receive(:get_films).with(now, gay_rabbit).and_return film_batch(now + 3.hours, 3)
    rovi_source.should_receive(:get_films).with(now + 4.hours, @film4).and_return film_batch(now + 8.hours, 1)
    rovi_source.should_receive(:get_films).with(now + 3.hours, gay_rabbit).and_return film_batch(now + 3.hours, 1)
    tv.get_films(@film4)
    tv.get_films(gay_rabbit)
    tv.get_films(@film4)
    tv.get_films(gay_rabbit)
  end

  def film_batch end_date, number_of_films
    film = Showing.new('Birdemic', Time.now, Time.now)
    stub(:end_date => end_date, :films => [film] * number_of_films)
  end
end
