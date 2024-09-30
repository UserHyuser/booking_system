# == Schema Information
#
# Table name: appointments
#
#  id             :bigint           not null, primary key
#  tickets_amount :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  event_id       :bigint
#  user_id        :bigint
#
# Indexes
#
#  index_appointments_on_event_id  (event_id)
#  index_appointments_on_user_id   (user_id)
#
require "rails_helper"

RSpec.describe Appointment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
