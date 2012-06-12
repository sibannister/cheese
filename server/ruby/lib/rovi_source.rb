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

  def get_films start_time, channel
    puts 'Requesting films starting at ' + start_time.to_s + " on " + channel.name
    soap = @soap_source.read start_time, channel
    puts 'Response received for ' + channel.name + " " + start_time.to_s
    puts 'Nil soap' if soap.nil?
    puts 'Empty soap' if !soap.nil? && soap.empty?
    return empty_batch(start_time) if soap.nil? || soap.empty? || has_no_programmes(soap)
    extract_films(soap)
  end

  def empty_batch start_time
    puts 'Creating default film batch'
    FilmBatch.new [], start_time + 240.minutes
  end

  def has_no_programmes soap
    no_programmes = !soap.include?("GridAiring")
    puts "  !! Soap contains no showings" if no_programmes
    no_programmes
  end

  def extract_films soap
    puts 'Extracting films from soap'
    doc = Hpricot.XML(soap)
    films = (doc/"GridAiring")
    puts films.count.to_s + ' showings in soap'
    end_date = end_date films.last
    films.delete_if {|film| film['Category'] != 'Movie' }
    films = films.map {|film| Showing.new film['Title'], start_date(film), end_date(film) }
    puts '  Films in soap: ' + films.to_s
    FilmBatch.new films, end_date
  end 

  def start_date film
    puts 'Airs at ' + film['AiringTime'].to_s
    Time.parse(film['AiringTime'])
  end

  def end_date film
    puts 'Duration of ' + film['Duration']
    Time.parse(film['AiringTime']) + film['Duration'].to_i.minutes
  end
end
