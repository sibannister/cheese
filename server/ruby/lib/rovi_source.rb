require 'soap_source'
require 'fixnum'
require 'hpricot'
require 'showing'
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
    puts 'Requesting films starting at ' + start_time.to_s
    soap = @soap_source.read start_time, 240
    return nil if soap.nil? || soap.empty? || has_no_programmes(soap)
    extract_films(soap)
  end

  def has_no_programmes soap
    !soap.include? "GridAiring"
  end

  def extract_films soap
    doc = Hpricot.XML(soap)
    films = (doc/"GridAiring")
    return nil if films.empty?
    end_date = end_date films.last
    films.delete_if {|film| film['Category'] != 'Movie' }
    films = films.map {|film| Showing.new film['Title'], start_date(film), end_date(film) }
    puts films
    FilmBatch.new films, end_date
  end 

  def start_date film
    Time.parse(film['AiringTime'])
  end

  def end_date film
    Time.parse(film['AiringTime']) + film['Duration'].to_i.minutes
  end
end
