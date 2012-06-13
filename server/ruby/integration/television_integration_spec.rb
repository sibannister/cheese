require 'television'
require 'channel'
require 'fixnum'

describe Television do
  it 'should run without failure' do
    tv = Television.new
    channel = Channel.new 'BBC 4', 24908
    10.times {tv.get_films channel, Time.now + 1.days}
  end
end
