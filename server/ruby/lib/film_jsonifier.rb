class FilmJsonifier
  def convert film
    return nil if film == nil
    '{"name" : "' + film.name + '", "rating" : ' + film.rating.to_s + '}'
  end
end
