require 'showing'
require 'fixnum'
require 'timecop'

describe Showing do
  before do
    Timecop.freeze
  end

  it 'should convert a film to a json string' do
    film = Showing.new "The Godfather", Time.new(2010, 4, 11, 23, 45, 0), 
      Time.new(2010, 4, 12, 1, 15, 0), 'ITV', 'imageurl', 9.2
    film.to_json.should == '{"name" : "The Godfather", "rating" : 9.2, "channel" : "ITV", "start" : "2010-04-11 23:45", "end" : "2010-04-12 01:15", "image" : "imageurl"}'
  end

  it 'should represent null film ratings as zero in the json string' do
    film = Showing.new "The Godfather", Time.new(2010, 4, 11, 23, 45, 0), 
      Time.new(2010, 4, 12, 1, 15, 0), 'ITV', 'imageurl', nil
    film.to_json.should == '{"name" : "The Godfather", "rating" : 0, "channel" : "ITV", "start" : "2010-04-11 23:45", "end" : "2010-04-12 01:15", "image" : "imageurl"}'
  end
  
  context 'equality' do
    it 'should recognise two identical films as equal' do
      film1 = Showing.new "Birdemic", Time.now, Time.now, 'ITV', "imageurl", 1.2
      film2 = Showing.new "Birdemic", Time.now, Time.now, 'ITV', "imageurl", 1.2
      film1.should == film2
    end

    it 'should recognise films on different channels as unequal' do
      film1 = Showing.new "Birdemic", Time.now, Time.now, 'ITV', "imageurl", 1.2
      film2 = Showing.new "Birdemic", Time.now, Time.now, 'Film 4', "imageurl", 1.2
      film1.should_not == film2
    end

    it 'should recognise two differently rated films as unequal' do
      film1 = Showing.new "Birdemic", Time.now, Time.now, 'ITV', "imageurl", 1.2
      film2 = Showing.new "Birdemic", Time.now, Time.now, 'ITV', "imageurl", 4.2
      film1.should_not == film2
    end

    it 'should recognise two differently named films as unequal' do
      film1 = Showing.new "Birdemic", Time.now, Time.now, 'ITV', "imageurl", 1.2
      film2 = Showing.new "Titanic", Time.now, Time.now, 'ITV', "imageurl", 1.2
      film1.should_not == film2
    end

    it 'should recognise films with different end times unequal' do
      film1 = Showing.new "Birdemic", Time.now, Time.now, "imageurl", 'ITV'
      film2 = Showing.new "Birdemic", Time.now, Time.now + 1.hours, "imageurl", 'ITV'
      film1.should_not == film2
    end

    it 'should recognise films with different start times unequal' do
      film1 = Showing.new "Birdemic", Time.now, Time.now, "imageurl", 'ITV'
      film2 = Showing.new "Birdemic", Time.now + 1.hours, Time.now, "imageurl", 'ITV'
      film1.should_not == film2
    end
    
    it 'should recognise films with different images as unequal' do
      film1 = Showing.new "Birdemic", Time.now, Time.now, "imageurl", 'ITV'
      film2 = Showing.new "Birdemic", Time.now, Time.now, "differentimageurl", 'ITV'
      film1.should_not == film2
    end
  end

end
