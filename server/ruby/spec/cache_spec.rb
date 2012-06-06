require 'cache'
require 'showing'

describe Cache do
  let (:tv) { stub }
  let (:reviewer) { stub }
  let (:film1) { Showing.new 'Birdemic', Time.now, Time.now }
  let (:film2) { Showing.new 'The Godfather', Time.now, Time.now }

  it 'should begin caching by retrieving and rating films and storing the results' do
    tv.should_receive(:get_films).and_return([film1, film2])
    reviewer.should_receive(:review).with('Birdemic').and_return(1.2)
    reviewer.should_receive(:review).with('The Godfather').and_return(9.2)
    Cache.build tv, reviewer
    Cache.new.get_films.should == [film1, film2]
  end
end
