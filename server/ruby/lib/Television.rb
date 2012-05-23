require 'hpricot'
require 'film'
require 'film_service_failure'

class Television
  def initialize soap_source = dummy_source
    @soap_source = soap_source
  end

  def dummy_source
    soap_response = File.read('rovi/get_grid_schedule_response.xml')
    stub(:get_films).and_return soap_response
  end

  def get_films 
    soap = @soap_source.get_films
    return [] if soap.nil? || soap.empty?
    doc = Hpricot.XML(soap)
    films = (doc/"gridairing")
    raise FilmServiceFailure if films.empty?
    films.map {|film| Film.new film['title'], 9.9}
  end
end
