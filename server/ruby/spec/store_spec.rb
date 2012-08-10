require 'timecop'
require 'store'
require 'showing'
require 'fixnum'

describe Store do
  let (:persister) { mock }
  let (:store) { Store.new persister }

  before do
    Timecop.freeze
  end

  def showing1
    Showing.new 'Birdemic', Time.now, Time.now + 2.hours, 'ITV', 'image', 1.2
  end

  def showing2
    Showing.new 'The Godfather', Time.now, Time.now + 3.hours, 'showing 4', 'image', 9.2
  end

  it "should allow adding and retrieving" do
    store.add [showing1]
    store.add [showing2]
    store.contents.should eq [showing1, showing2]
  end

  it "should return the showings in json format" do
    persister.should_receive(:retrieve).and_return nil
    store.add [showing1]
    store.add [showing2]
    store.get_json.should eq "[" + showing1.to_json + ", " + showing2.to_json + "]"
  end

  it "should retrieve the persisted showings json" do
    persister.should_receive(:save).with "[" + showing1.to_json + "]"
    persister.should_receive(:retrieve).and_return "some json"
    store.add [showing1]
    store.persist
    store.get_json.should eq "some json"
  end

end
