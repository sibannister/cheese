require 'timecop'
require 'fixnum'
require 'television'
require 'film_service_failure'

describe Television do
  let(:rovi_source) { stub }
  let(:tv) { Television.new rovi_source }
  
  it 'should keep requesting film soap responses until 7 days worth are retrieved' do
    Timecop.freeze
    now = Time.now
    rovi_source.should_receive(:get_films).with(now).and_return film_batch(now + 3.days, 3)
    rovi_source.should_receive(:get_films).with(now + 3.days).and_return film_batch(now + 8.days, 2) 
    tv.get_films.should have(5).items
  end

  def film_batch end_date, number_of_films
    stub(:end_date => end_date, :films => [Showing.new('Birdemic', 1.2, Time.now)] * number_of_films)
  end
end
