require 'factory_girl'

RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods
end

FactoryGirl.define do
  factory :showing do
    ignore do
      name        "Birdemic"
      start_date  Time.now
      end_date    Time.now
      channel     "Film4"
      image_url   "Some url"
      rating      1.2
    end
  end

  initialize_with { new(name, start_date, end_date, channel, image_url, rating) }

  factory :another_showing, parent: :showing do
    name          "The Godfather"
    rating         8.7
  end
end
