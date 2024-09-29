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
    name { "MyString" }
    description { "MyString" }
    location { "MyString" }
    datetime { "2024-09-29 12:32:04" }
    tickets_available { 1 }
  end
end
