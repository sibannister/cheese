require 'timecop'
require 'fixnum'
require 'television'
require 'film_service_failure'

describe Television do
  let(:rovi_source) { stub }
  let(:tv) { Television.new rovi_source }
  
  it 'should retrieve films from rovi' do
    Timecop.freeze
    now = Time.now
    rovi_source.should_receive(:get_films).with(now).and_return film_batch(now + 4.hours, 3)
    tv.get_films.should have(3).items
  end

  it 'should begin retrieving from the point where it left off' do
    Timecop.freeze
    now = Time.now
    rovi_source.should_receive(:get_films).with(now).and_return film_batch(now + 4.hours, 3)
    rovi_source.should_receive(:get_films).with(now + 4.hours).and_return film_batch(now + 8.hours, 1)
    tv.get_films.should have(3).items
    tv.get_films.should have(1).items
  end

  def film_batch end_date, number_of_films
    film = Showing.new('Birdemic', Time.now, Time.now)
    stub(:end_date => end_date, :films => [film] * number_of_films)
  end
end
