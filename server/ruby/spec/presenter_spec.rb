require 'spec_helper'
require 'presenter'
require 'channel'
require 'showing'
require 'memory_store'

describe Presenter do
  let (:tv) { stub }
  let (:reviewer) { stub }
  let (:store) { MemoryStore.new }
  let (:presenter) { Presenter.new tv, reviewer, store }
  let (:showing) { build :showing }
  let (:another_showing) { build :another_showing }

  before do
    Timecop.freeze
  end

  it 'should handle batches without any showings' do
    tv.should_receive(:reset)
    tv.should_receive(:get_next).and_return [showing], [], [another_showing]
    reviewer.should_receive(:review).with(showing.name).and_return [1.2, 'image']
    reviewer.should_receive(:review).with(another_showing.name).and_return [9.2, 'image']
    tv.should_receive(:all_showings_retrieved?).and_return false, false, true

    presenter.build_cache(0).should == [showing, another_showing].to_json
    presenter.get_showings.should == [showing, another_showing].to_json
  end

  it 'should handle the case where there are no showings at all' do
    tv.should_receive(:reset)
    tv.should_receive(:get_next).and_return []
    tv.should_receive(:all_showings_retrieved?).and_return true
    presenter.build_cache 0
    presenter.get_showings.should == [].to_json
  end

  it 'should integrate correctly with the Television class' do
    rovi_source = stub :get_next => ShowingBatch.new([], Time.now)
    real_tv = Television.new rovi_source
    presenter = Presenter.new real_tv, reviewer, store
    presenter.build_cache 0
    presenter.get_showings
  end

  it 'should integrate correctly with the FilmReviewer class' do
    tv.should_receive(:reset)
    tv.should_receive(:get_next).and_return []
    tv.should_receive(:all_showings_retrieved?).and_return true
    real_reviewer = FilmReviewer.new
    presenter = Presenter.new tv, real_reviewer, store
    presenter.build_cache 0
    presenter.get_showings
  end

  it 'should integrate correctly with the Store class' do
    tv.should_receive(:reset)
    tv.should_receive(:get_next).and_return []
    tv.should_receive(:all_showings_retrieved?).and_return true
    real_store = Store.new
    presenter = Presenter.new tv, stub, real_store
    presenter.build_cache 0
    presenter.get_showings
  end
end
