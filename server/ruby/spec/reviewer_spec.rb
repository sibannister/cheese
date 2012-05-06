require 'reviewer'

describe Reviewer do
  before :each do
    @reviewer = Reviewer.new
  end

  it 'should return a nil when asked to review and unknown film' do
    @reviewer.review('unknown film').should be_nil
  end

  it 'should return the imdb rating for a known unqiue film' do
    @reviewer.review('The Godfather').should eq 9.2
  end
end
