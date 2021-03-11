FactoryBot.define do
  factory :item do
    name              {Faker::Name.initials}
    description       {Faker::Lorem.sentence}
    price             {2000}
    category_id       {Faker::Number.between(from: 2, to: 11)}
    cost_id           {Faker::Number.between(from: 2, to: 3)}
    delivery_id       {Faker::Number.between(from: 2, to: 4)}
    prefecture_id     {Faker::Number.between(from: 2, to: 48)}
    status_id         {Faker::Number.between(from: 2, to: 7)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
