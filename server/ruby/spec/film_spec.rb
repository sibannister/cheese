require 'film'

describe Film do
  it 'should convert a film to a json string' do
    film = Film.new "The Godfather", 9.2
    film.to_json().should == '{"name" : "The Godfather", "rating" : 9.2}'
  end

  it 'should recognise two identical films as equal' do
    film1 = Film.new "Birdemic", 2.3
    film2 = Film.new "Birdemic", 2.3
    film1.should == film2
  end

  it 'should recognise two differently rated films as unequal' do
    film1 = Film.new "Birdemic", 2.3
    film2 = Film.new "Birdemic", 4.6
    film1.should_not == film2
  end

  it 'should recognise two differently named films as unequal' do
    film1 = Film.new "Birdemic", 2.3
    film2 = Film.new "Titanic", 2.3
    film1.should_not == film2
  end

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
    Film.new(title, 10).match_title? candidate_title
  end
end
