require 'television'
require 'channel'

describe Television do
  it 'should run without failure' do
    tv = Television.new
    channel = Channel.new 'BBC 4', 24908
    10.times {tv.get_films channel}
  end
end
