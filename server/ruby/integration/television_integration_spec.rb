require 'television'
require 'channel'
require 'fixnum'

describe Television do
  it 'should run without failure' do
    film4 = Channel.new 'Film 4', 25409
    bbc1 = Channel.new 'BBC 1', 24872
    tv = Television.new(RoviSource.new(SoapSource.new, [film4, bbc1]), Time.now + 2.days)
    10.times {tv.get_next}
  end
end
