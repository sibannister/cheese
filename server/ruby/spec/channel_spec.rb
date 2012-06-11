require 'channel'
require 'showing'

describe Channel do
  let (:film4) {Channel.new 'Film 4', 123}

  it 'should create a correct json string with zero films' do
    film4.to_json.should == '{"name" : "Film 4", "films" : []}'
  end

  it 'should create a correct json string with one film' do
    birdemic = Showing.new 'Birdemic', Time.new(2010, 4, 11, 23, 45, 0), Time.now
    film4 << birdemic
    film4.to_json.should == '{"name" : "Film 4", "films" : [{"name" : "Birdemic", "rating" : 0, "start" : "2010-04-11 23:45"}]}'
  end
end
