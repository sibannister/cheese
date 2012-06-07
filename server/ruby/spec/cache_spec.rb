require 'cache'
require 'showing'

describe Cache do
  let (:tv) { stub }
  let (:reviewer) { stub }
  let (:film1) { Showing.new 'Birdemic', Time.now, Time.now }
  let (:film2) { Showing.new 'The Godfather', Time.now, Time.now }

  it 'should retrieve films until there are no more' do
    tv.should_receive(:get_films).and_return([film1], [film2], [])
    reviewer.should_receive(:review).with('Birdemic').and_return(1.2)
    reviewer.should_receive(:review).with('The Godfather').and_return(9.2)
    Cache.build tv, reviewer
    Cache.new.get_films.should == [film1, film2]
  end

  it 'should handle the case where there are no films at all' do
    tv.should_receive(:get_films).and_return([])
    Cache.build tv, reviewer
    Cache.new.get_films.should == []
  end

  it 'should integrate correctly with the Television class' do
    rovi_source = stub(:get_films => FilmBatch.new([], Time.now))
    tv = Television.new rovi_source
    Cache.build tv, reviewer
    Cache.new.get_films
  end

  it 'should integrate correctly with the FilmReviewer class' do
    tv.should_receive(:get_films).and_return([])
    reviewer = stub
    Cache.build tv, reviewer
    Cache.new.get_films
  end
end
