require 'presenter'
require 'channel'
require 'showing'
require 'timecop'
require 'memory_store'

describe Presenter do
  let (:tv) { stub }
  let (:reviewer) { stub }
  let (:store) { MemoryStore.new }
  let (:presenter) { Presenter.new tv, reviewer, store, 0 }

  before do
    Timecop.freeze
  end

  def film1
    Showing.new 'Birdemic', Time.now, Time.now + 2.hours, 'ITV', 'image', 1.2
  end

  def film2
    Showing.new 'The Godfather', Time.now, Time.now + 3.hours, 'Film 4', 'image', 9.2
  end

  it 'should handle batches without any films' do
    tv.should_receive(:get_films).and_return([film1], [], [film2])
    reviewer.should_receive(:review).with('Birdemic').and_return([1.2, 'image'])
    reviewer.should_receive(:review).with('The Godfather').and_return([9.2, 'image'])
    tv.should_receive(:films_retrieved_up_to?).and_return(false, false, true)
    presenter.build 
    sleep 1

    presenter.get_films.should == jsonify([film1, film2])
  end

  it 'should handle the case where there are no films at all' do
    tv.should_receive(:get_films).and_return([])
    tv.should_receive(:films_retrieved_up_to?).and_return(true)
    presenter.build
    presenter.get_films.should == "[]"
  end

  it 'should integrate correctly with the Television class' do
    rovi_source = stub(:get_films => FilmBatch.new([], Time.now + 5.hours))
    real_tv = Television.new rovi_source
    presenter = Presenter.new real_tv, reviewer, store, 0
    presenter.build
    presenter.get_films
  end

  it 'should integrate correctly with the FilmReviewer class' do
    tv.should_receive(:get_films).and_return([])
    tv.should_receive(:films_retrieved_up_to?).and_return(true)
    reviewer = stub
    presenter.build 
    presenter.get_films
  end

  def jsonify films
    films_json = films.map {|film| film.to_json}
    '[' + films_json.join(', ') + ']'
  end
end
