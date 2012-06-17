require 'television'
require 'channel'
require 'fixnum'

describe Television do
  it 'should run without failure' do
    film4 = Channel.new 'Film 4', 25409
    bbc1 = Channel.new 'BBC 1', 24872
    tv = Television.new(RoviSource.new(SoapSource.new, [film4, bbc1]))
    10.times {tv.get_films Time.now + 1.days}
  end
end
