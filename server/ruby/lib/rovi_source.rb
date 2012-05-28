require 'soap_source'
require 'fixnum'
require 'hpricot'
require 'film'
require 'film_service_failure'

class FilmBatch
  def initialize films, end_date
    @films = films
    @end_date = end_date
  end

  def films
    @films
  end

  def end_date
    @end_date
  end
end

class RoviSource
  def initialize soap_source = SoapSource.new
    @soap_source = soap_source
  end

  def get_films start_time
    soap = @soap_source.read
    films = (soap.nil? || soap.empty?) ? [] : extract_films(soap)
    FilmBatch.new films, (films.empty? ? nil : films.last.end_date)
  end

  def extract_films soap
    doc = Hpricot.XML(soap)
    films = (doc/"GridAiring")
    raise FilmServiceFailure if films.empty?
    films.delete_if {|film| film['Category'] != 'Movie' }
    films.map {|film| Film.new film['Title'], 9.9, end_date(film) }
  end 

  def end_date film
    start_date = Time.parse(film['AiringTime']) + film['Duration'].to_i.minutes
  end
end
