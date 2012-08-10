require 'timecop'
require 'store'
require 'showing'
require 'fixnum'

describe Store do
  let (:store) { Store.new }

  before do
    Timecop.freeze
    store.reset
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

  it "should return the films in json format" do
    store.add [film1]
    store.add [film2]
    store.get_json.should eq "[" + film1.to_json + ", " + film2.to_json + "]"
  end

  it "should retrieve the persisted films json" do
    store.add [film1]
    store.persist
    store.get_json.should eq "[" + film1.to_json + "]"
  end

  it "should use the persisted films rather than the in memory films" do
    store.add [film1]
    store.persist
    store.add [film2]
    store.get_json.should eq "[" + film1.to_json + "]"
  end

end
