require 'television'
require 'film_service_failure'

describe Television do
  let(:soap_source) { stub }
  let(:tv) { Television.new soap_source }

  it 'should return no films from a nil soap packet' do
    soap_source.stub(:get_films).and_return nil
    tv.get_films.should be_empty
  end

  it 'should return no films from an empty soap packet' do
    soap_source.stub(:get_films).and_return ''
    tv.get_films.should be_empty
  end

  it 'should raise an error from a junk soap packet' do
    soap_source.stub(:get_films).and_return 'wibble'
    expect {tv.get_films}.to raise_error(FilmServiceFailure)
  end
end
