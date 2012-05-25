require 'fixnum'
require 'hpricot'
require 'film'
require 'film_service_failure'
require 'soap_source'

class Television
  def initialize soap_source = SoapSource.new, rovi_source
    @soap_source = soap_source
    @rovi_source = rovi_source
  end

  def get_films2
    start = Time.now
    films = []
    until start >= Time.now + 7.days
      batch = @rovi_source.get_films start
      puts batch.films.count
      films = films + batch.films
      puts films.count
      start = batch.end_date
    end
    films
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
