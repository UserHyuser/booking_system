class CreateAppointmentContract < Dry::Validation::Contract
  params do
    required(:event_id).filled(:integer, gteq?: 1)
    required(:user_id).filled(:integer, gteq?: 1)
    required(:tickets_amount).filled(:integer, gteq?: 1)
  end
end
