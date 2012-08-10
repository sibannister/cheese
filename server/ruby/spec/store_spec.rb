require 'factory_girl'
require 'timecop'
require 'store'
require 'showing'
require 'fixnum'
require 'jsonifier'


FactoryGirl.find_definitions

describe Store do
  let (:persister) { mock }
  let (:store) { Store.new persister }
  let (:showing) { build :showing }
  let (:another_showing) { build :another_showing }

  before do
    Timecop.freeze
  end

  it "should allow adding and retrieving" do
    store.add [showing]
    store.add [another_showing]
    store.contents.should eq [showing, another_showing]
  end

  it "should return the showings in json format" do
    persister.should_receive(:retrieve).and_return nil
    store.add [showing]
    store.add [another_showing]
   # store.get_json.should eq "[" + showing.to_json + ", " + another_showing.to_json + "]"
    store.get_json.should eq [showing, another_showing].to_json
  end

  it "should retrieve the persisted showings json" do
    persister.should_receive(:save).with "[" + showing.to_json + "]"
    persister.should_receive(:retrieve).and_return "some json"
    store.add [showing]
    store.persist
    store.get_json.should eq "some json"
  end

end
