require 'film_repository'
require 'film'

describe FilmRepository do
  before :each do
    @repository = FilmRepository.new
  end

  it 'should return a nil when asked to find and unknown film' do
    @repository.find('there is no film with this name').should be_nil
  end

  it 'should return the film for a known unqiue film name' do
    @repository.find('The Godfather').should == Film.new('The Godfather', 9.2)
  end
end
