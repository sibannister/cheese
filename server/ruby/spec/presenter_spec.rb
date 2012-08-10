require 'presenter'
require 'channel'
require 'showing'
require 'spec_helper'
require 'memory_store'

describe Presenter do
  let (:tv) { stub }
  let (:reviewer) { stub }
  let (:store) { MemoryStore.new }
  let (:presenter) { Presenter.new tv, reviewer, store }

  before do
    Timecop.freeze
  end

  def showing1
    Showing.new 'Birdemic', Time.now, Time.now + 2.hours, 'ITV', 'image', 1.2
  end

  def showing2
    Showing.new 'The Godfather', Time.now, Time.now + 3.hours, 'Film 4', 'image', 9.2
  end

  it 'should handle batches without any showings' do
    tv.should_receive(:get_showings).and_return([showing1], [], [showing2])
    reviewer.should_receive(:review).with('Birdemic').and_return([1.2, 'image'])
    reviewer.should_receive(:review).with('The Godfather').and_return([9.2, 'image'])
    tv.should_receive(:showings_retrieved_up_to?).and_return(false, false, true)
    presenter.build_cache 0
    sleep 1

    presenter.get_showings.should == [showing1, showing2].to_json
  end

  it 'should handle the case where there are no showings at all' do
    tv.should_receive(:get_showings).and_return([])
    tv.should_receive(:showings_retrieved_up_to?).and_return(true)
    presenter.build_cache 0
    presenter.get_showings.should == "[]"
  end

  it 'should integrate correctly with the Television class' do
    rovi_source = stub :get_showings => ShowingBatch.new([], Time.now + 5.hours)
    real_tv = Television.new rovi_source
    presenter = Presenter.new real_tv, reviewer, store
    presenter.build_cache 0
    presenter.get_showings
  end

  it 'should integrate correctly with the FilmReviewer class' do
    tv.should_receive(:get_showings).and_return([])
    tv.should_receive(:showings_retrieved_up_to?).and_return(true)
    reviewer = stub
    presenter.build_cache 0
    presenter.get_showings
  end
end
