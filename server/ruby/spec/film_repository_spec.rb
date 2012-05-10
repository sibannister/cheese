require 'film_repository'

describe FilmRepository do
  before :each do
    @repository = FilmRepository.new
  end

  it 'should return a nil when asked to find and unknown film' do
    @repository.find('unknown film').should be_nil
  end

  it 'should return the imdb rating for a known unqiue film' do
    @repository.find('The Godfather').should eq 9.2
  end
end
