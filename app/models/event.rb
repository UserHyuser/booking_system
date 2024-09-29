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
class Event < ApplicationRecord
end
