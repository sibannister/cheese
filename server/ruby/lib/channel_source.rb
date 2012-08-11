require 'channel'

class ChannelSource < Array
  def initialize
    read_channels
  end

  def read_channels
    File.open("channels.txt").map {|line| read_channel(line)}
  end

  def read_channel line
    channel = Channel.new line.split(',')[0], line.split(',')[1].to_i
    self << channel
  end
end
