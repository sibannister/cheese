require 'film_reviewer'
require 'showing'

describe FilmReviewer do
  let (:reviewer) { FilmReviewer.new }


  #it 'should handle alternative film titles' do
    #reviewer.review('Gegen die Wand').should == reviewer.review('Head-on')
  #end

  it 'should not confuse The Drum with Tin Drum' do
    reviewer.review('The Drum')[0].should == 6.6
  end

  it 'should not confuse Infamous with The Childrens Hour' do
    reviewer.review('Infamous')[0].should == 7.0
  end

  it 'should not confuse The Tall Men with All The Presidents Men' do
    reviewer.review('The Tall Men')[0].should == 6.6
  end

  #it 'should return a nil when asked to review an unknown film' do
    #reviewer.review('there is no film with this name').should be_nil
  #end

  it 'should return a rating for a known unqiue film name' do
    reviewer.review('The Godfather').should == [9.2, 'http://ia.media-imdb.com/images/M/MV5BMTIyMTIxNjI5NF5BMl5BanBnXkFtZTcwNzQzNDM5MQ@@.jpg']
  end

  it 'should handle sequels' do
    reviewer.review('Night at the museum 2').should_not be_nil
  end

end
