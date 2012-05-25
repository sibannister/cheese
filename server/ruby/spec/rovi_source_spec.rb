require 'rovi_source'

describe 'RoviSource' do
  let (:source) { RoviSource.new }

  it 'should extract films from rovi soap xml' do
    batch = source.get_films Time.now
    batch.films.should_not be_empty
  end
end

