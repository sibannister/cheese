require 'television'
require 'film_service_failure.rb'

describe Television do
  let(:soap_source) { stub }
  let(:tv) { Television.new soap_source }

  it 'should return no films from an empty soap packet' do
    #tv.get_films.should be_empty
  end

  it 'should raise an error from a junk soap packet' do
    #soap_source = stub(:get_films => 'wibble')
    #tv.get_films.should raise_error(FilmServiceFailure)
  end
end
