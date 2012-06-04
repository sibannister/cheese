require 'television'

describe Television do
  it 'should run without failure' do
    Television.new.get_films 1
  end
end
