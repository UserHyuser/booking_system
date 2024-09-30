module Creators
  class AppointmentCreator < Base
    def call
      @record = Appointment.new(@params)

      validate_params
      return self unless record.errors.empty?

      ActiveRecord::Base.transaction do
        lock_event
        raise ActiveRecord::Rollback unless validate_tickets_availability

        create_record
        raise ActiveRecord::Rollback unless record.errors.empty?

        update_event_tickets
      end

      self
    rescue ActiveRecord::RecordInvalid
      record.errors.add(:base, I18n.t("controllers.appointments.purchase_failed"))
      self
    end

    private

    def creation_contract
      CreateAppointmentContract
    end

    def lock_event
      @event = Event.lock.find(@params[:event_id])
    end

    def validate_tickets_availability
      if @params[:tickets_amount].to_i > @event.tickets_available
        record.errors.add(:base, I18n.t("controllers.appointments.not_enough_tickets"))
        false
      else
        true
      end
    end

    def create_record
      @record.save
    end

    def update_event_tickets
      @event.update!(tickets_available: @event.tickets_available - @params[:tickets_amount].to_i)
    end
  end
end
