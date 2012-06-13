require 'informer'

describe Informer do
  it 'should send emails' do
    Informer.new.send 'Hello', 'spencerkward@gmail.com'
  end
end
