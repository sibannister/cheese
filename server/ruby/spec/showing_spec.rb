require 'showing'
require 'fixnum'
require 'timecop'

describe Showing do
  before do
    Timecop.freeze
  end

  it 'should convert a film to a json string' do
    film = Showing.new "The Godfather", 9.2, Time.now
    film.to_json().should == '{"name" : "The Godfather", "rating" : 9.2}'
  end

  context 'equality' do
    it 'should recognise two identical films as equal' do
      film1 = Showing.new "Birdemic", 2.3, Time.now
      film2 = Showing.new "Birdemic", 2.3, Time.now
      film1.should == film2
    end

    it 'should recognise two differently rated films as unequal' do
      film1 = Showing.new "Birdemic", 2.3, Time.now
      film2 = Showing.new "Birdemic", 4.6, Time.now
      film1.should_not == film2
    end

    it 'should recognise two differently named films as unequal' do
      film1 = Showing.new "Birdemic", 2.3, Time.now
      film2 = Showing.new "Titanic", 2.3, Time.now
      film1.should_not == film2
    end

    it 'should recognise two differently timed films as unequal' do
      film1 = Showing.new "Birdemic", 2.3, Time.now
      film2 = Showing.new "Birdemic", 2.3, Time.now + 1.hours
      film1.should_not == film2
    end
  end

  context 'title matching' do
    it 'should match on exact title' do
      match('The Godfather','The Godfather').should be_true
    end

    it 'should match on title regardless of case differences' do
      match('The Godfather','THE Godfather').should be_true
    end 

    it 'should match on title regardless of trailing characters' do
      match('The Godfather', 'The Godfather (1977)  ').should be_true
    end

    it 'should not match if titles different' do
      match('The Godfather', 'The Seventh Seal').should be_false
    end

    def match title, candidate_title
      Showing.match_title? title, candidate_title
    end
  end
end
