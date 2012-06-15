require 'cache'
require 'channel'
require 'showing'
require 'timecop'

describe Cache do
  let (:tv) { stub }
  let (:reviewer) { stub }
  let (:film1) { Showing.new 'Birdemic', Time.now, Time.now + 3.hours, 2.3, 'ITV' }
  let (:film2) { Showing.new 'The Godfather', Time.now, Time.now + 3.hours, 6.4, 'Film 4' }
  let (:channel) { Channel.new 'Gay Rabbit', 123 }
  let (:channels) { [channel] }

  before do
    Timecop.freeze
  end

  it 'should combine films from different channels' do
    other_channel = Channel.new 'ITV', 456
    tv.should_receive(:get_films).with([channel, other_channel], Time.now + 1.hours).and_return([film1, film2])
    tv.should_receive(:films_retrieved_up_to?).and_return(true)
    Cache.build tv, reviewer, [channel, other_channel], 1.hours
    Cache.new.get_films.should == [film1, film2]
  end

  it 'should handle batches without any films' do
    tv.should_receive(:get_films).and_return([film1], [], [film2])
    reviewer.should_receive(:review).with('Birdemic').and_return(1.2)
    reviewer.should_receive(:review).with('The Godfather').and_return(9.2)
    tv.should_receive(:films_retrieved_up_to?).and_return(false, false, true)
    Cache.build tv, reviewer, channels, 0.minutes
    Cache.new.get_films.should == [film1, film2]
  end

  it 'should handle the case where there are no films at all' do
    tv.should_receive(:get_films).and_return([])
    tv.should_receive(:films_retrieved_up_to?).and_return(true)
    Cache.build tv, reviewer, channels, 0.minutes
    Cache.new.get_films.should == []
  end

  it 'should integrate correctly with the Television class' do
    rovi_source = stub(:get_films => FilmBatch.new([], Time.now + 5.hours))
    tv = Television.new rovi_source
    Cache.build tv, reviewer, channels, 0.minutes
    Cache.new.get_films
  end

  it 'should integrate correctly with the FilmReviewer class' do
    tv.should_receive(:get_films).and_return([])
    tv.should_receive(:films_retrieved_up_to?).and_return(true)
    reviewer = stub
    Cache.build tv, reviewer, channels, 0.minutes
    Cache.new.get_films
  end
end
