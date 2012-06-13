require 'channel'
require 'showing'

describe Channel do
  let (:film4) {Channel.new 'Film 4', 123}

  it 'should create a correct json string with zero films' do
    film4.to_json.should == '{"name" : "Film 4", "films" : []}'
  end
end
