require 'channel'
require 'spec_helper'

describe Channel do
  it 'should implement a to string' do
    channel = build :channel 
    channel.to_s.should_not be_nil
    channel.to_s.should include channel.name
  end
end
