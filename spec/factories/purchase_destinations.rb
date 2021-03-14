FactoryBot.define do
  factory :purchase_destination do
    post_code { '123-4567' }
    prefecture_id { 3 }
    city { '新宿区' }
    address { '1-1' }
    building_name { '東京ハイツ' }
    phone_number { '09012345678' }
    token {"tok_abcdefghijk00000000000000000"}

  end
end
