require 'soap_source'
require 'fixnum'
require 'hpricot'
require 'showing'
require 'film_service_failure'

class FilmBatch
  def initialize films
    @films = films
  end

  def films
    @films
  end

  def end_date
    films.empty? ? nil : films.last.end_date
  end
end

class RoviSource
  def initialize soap_source = SoapSource.new
    @soap_source = soap_source
  end

  def get_films start_time
    puts 'Requesting films starting at ' + start_time.to_s
    soap = @soap_source.read start_time, 240
    films = (soap.nil? || soap.empty?) ? [] : extract_films(soap)
    FilmBatch.new films
  end

  def extract_films soap
    doc = Hpricot.XML(soap)
    films = (doc/"GridAiring")
    raise FilmServiceFailure if films.empty?
    films.delete_if {|film| film['Category'] != 'Movie' }
    films.map {|film| Showing.new film['Title'], 9.9, end_date(film) }
  end 

  def end_date film
    start_date = Time.parse(film['AiringTime']) + film['Duration'].to_i.minutes
  end
end
