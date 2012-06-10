require 'film_reviewer'
require 'showing'

describe FilmReviewer do
  let (:reviewer) { FilmReviewer.new }

  #it 'should return a nil when asked to review an unknown film' do
    #reviewer.review('there is no film with this name').should be_nil
  #end

  it 'should return a rating for a known unqiue film name' do
    reviewer.review('The Godfather').should == 9.2
  end

  it 'should handle sequels' do
    reviewer.review('Night at the museum 2').should_not be_nil
  end

  it 'should handle alternative film titles' do
    reviewer.review('Gegen die Wand').should == reviewer.review('Head on')
  end
end
