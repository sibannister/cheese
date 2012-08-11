require 'factory_girl'
require 'fixnum'

RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods
end

FactoryGirl.define do
  factory :showing do
    initialize_with { new(name, start_date, end_date, channel, image_url, rating) }

    ignore do
      name        "Birdemic"
      start_date  Time.new(2010, 4, 12, 1, 15, 0)
      end_date    Time.new(2010, 4, 12, 2, 45, 0)
      channel     "Film4"
      image_url   "Some url"
      rating      1.2
    end
  end

  factory :another_showing, parent: :showing do
    name          "The Godfather"
    rating         8.7
  end

  factory :channel do
    initialize_with { new(name, code) }

    ignore do
      name        "Film4"
      code        1234
    end
  end

  factory :showing_batch do
    initialize_with { new([(build :showing)] * number_of_showings, end_time) }

    ignore do
      number_of_showings  2
      end_time            Time.now + 1.days
    end
  end
end
