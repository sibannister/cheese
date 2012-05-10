require 'film'

describe Film do
  it 'should convert a film to a json string' do
    film = Film.new "The Godfather", 9.2
    film.to_json().should eq '{"name" : "The Godfather", "rating" : 9.2}'
  end
end
