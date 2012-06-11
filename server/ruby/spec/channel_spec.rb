require 'channel'

describe Channel do
  it 'should create a correct jason string with zero films' do
    film4 = Channel.new 'Film 4', 123
    film4.to_json.should == '{"name" : "Film 4", "films" : []}'
  end


    #film.to_json.should == '{"name" : "The Godfather", "rating" : 9.2, "start" : "2010-04-11 23:45"}'
end
