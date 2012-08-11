require 'spec_helper'
require 'television'

describe Television do
  let(:in2hours) { now + 2.hours }
  let(:in4hours) { now + 4.hours }
  let(:in8hours) { now + 8.hours }
  let(:rovi_source) { stub }
  let(:tv) { Television.new rovi_source, end_time = in8hours }
  let(:now) { Timecop.freeze }

  it 'should not attempt to retrieve any showings if it has passed the required end time' do
    tv.reset end_time = in2hours
    rovi_source.should_receive(:get_showings).with(now).and_return showing_batch in4hours, 3
    tv.get_next.should have(3).items
    tv.get_next.should be_empty
  end
  
  it 'should know when it has retrieved all the showings' do
    rovi_source.should_receive(:get_showings).with(now).and_return showing_batch in4hours
    rovi_source.should_receive(:get_showings).with(in4hours).and_return showing_batch in8hours
    tv.all_showings_retrieved?.should be_false
    tv.get_next
    tv.all_showings_retrieved?.should be_false
    tv.get_next
    tv.all_showings_retrieved?.should be_true
  end
  
  it 'should begin retrieving from the point where it left off' do
    rovi_source.should_receive(:get_showings).with(now).and_return showing_batch in4hours, 3
    rovi_source.should_receive(:get_showings).with(in4hours).and_return showing_batch in8hours, 1
    tv.get_next.should have(3).items
    tv.get_next.should have(1).items
  end

  it 'should integrate with rovi source' do
    stub_soap = stub :read => nil
    real_rovi = RoviSource.new stub_soap, []
    tv = Television.new real_rovi, in8hours
    tv.get_next
  end

  def showing_batch end_time, number_of_showings = 1
    build :showing_batch, :end_time => end_time, :number_of_showings => number_of_showings
  end
end
