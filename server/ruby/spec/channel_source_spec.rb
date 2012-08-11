require 'channel_source'

describe ChannelSource do
  it 'should act like an array' do
    channels = ChannelSource.new
    channels.size.should > 0
    channels.each { |channel| puts channel }
  end
end

