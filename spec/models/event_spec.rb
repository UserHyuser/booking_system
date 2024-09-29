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
require "rails_helper"

RSpec.describe Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
