require 'film'

class Television
  def get_films 
    film1 = Film.new('The Godfather', 2.3)
    film2 = Film.new('Birdemic', 2.3)
    [film1, film2]
  end
end
