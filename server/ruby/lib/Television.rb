require 'film'
require 'film_service_failure'

class Television
  def initialize soap_source
    @soap_source = soap_source
  end

  def get_films 
    soap = @soap_source.get_films
    return [] if soap.nil? || soap.empty?
    raise FilmServiceFailure
  end
end
