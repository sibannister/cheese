require 'hpricot'
require 'film'
require 'film_service_failure'
require 'soap_source'

class Television
  def initialize soap_source = SoapSource.new
    @soap_source = soap_source
  end

  def get_films 
    soap = @soap_source.read
    return [] if soap.nil? || soap.empty?
    extract_films soap
  end

  def extract_films soap
    doc = Hpricot.XML(soap)
    films = (doc/"GridAiring")
    raise FilmServiceFailure if films.empty?
    films.delete_if {|film| film['Category'] != 'Movie' }
    films.map {|film| Film.new film['Title'], 9.9 }
  end
end
