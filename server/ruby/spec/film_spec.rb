require 'film'
require 'timecop'

describe Film do
  before do
    Timecop.freeze
  end

  it 'should convert a film to a json string' do
    film = Film.new "The Godfather", 9.2, Time.now
    film.to_json().should == '{"name" : "The Godfather", "rating" : 9.2}'
  end

  context 'equality' do
    it 'should recognise two identical films as equal' do
      film1 = Film.new "Birdemic", 2.3, Time.now
      film2 = Film.new "Birdemic", 2.3, Time.now
      film1.should == film2
    end

    it 'should recognise two differently rated films as unequal' do
      film1 = Film.new "Birdemic", 2.3, Time.now
      film2 = Film.new "Birdemic", 4.6, Time.now
      film1.should_not == film2
    end

    it 'should recognise two differently named films as unequal' do
      film1 = Film.new "Birdemic", 2.3, Time.now
      film2 = Film.new "Titanic", 2.3, Time.now
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
      Film.new(title, 10, Time.now).match_title? candidate_title
    end
  end
end
