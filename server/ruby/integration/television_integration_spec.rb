require 'television'

describe Television do
  it 'should run without failure' do
    Television.new.get_films
  end
end
