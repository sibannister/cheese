require 'timecop'
require 'store'
require 'showing'
require 'fixnum'

describe Store do
  let (:store) { Store.new }

  before do
    Timecop.freeze
  end

  def film1
    Showing.new 'Birdemic', Time.now, Time.now + 2.hours, 'ITV', 'image', 1.2
  end

  def film2
    Showing.new 'The Godfather', Time.now, Time.now + 3.hours, 'Film 4', 'image', 9.2
  end

  it "should allow adding and retrieving" do
    store.add [film1]
    store.add [film2]
    store.contents.should eq [film1, film2]
  end
end
