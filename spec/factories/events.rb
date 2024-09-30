# == Schema Information
#
# Table name: events
#
#  id                :bigint           not null, primary key
#  datetime          :datetime
#  description       :string
#  location          :string
#  name              :string
#  tickets_available :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
FactoryBot.define do
  factory :event do
    name { Faker::Music::RockBand.name }
    description { Faker::Lorem.sentence }
    location { Faker::Address.full_address }
    datetime { DateTime.current + rand(1..10).days }
    tickets_available { rand(1..100) }
  end
end
