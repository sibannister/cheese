require 'film_jsonifier'
require 'film'

describe FilmJsonifier do
  before :each do
    @jsonifier = FilmJsonifier.new
  end

  it 'should convert a nil film to a nil json string' do
    @jsonifier.convert(nil).should be_nil
  end

  it 'should convert a film to a json string' do
    film = Film.new "The Godfather", 9.2
    @jsonifier.convert(film).should eq '{"name" : "The Godfather", "rating" : 9.2}'
  end
end
