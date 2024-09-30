class AppointmentsController < ApplicationController
  # GET /appointments
  def index
    @appointments = current_user.appointments.includes(:event)
  end

  # POST /appointments
  def create
    result = ::Creators::AppointmentCreator.call(appointment_params)

    if result.success?
      redirect_to appointments_path, notice: I18n.t("controllers.appointments.purchase_successful")
    else
      flash[:alert] = I18n.t("controllers.appointments.purchase_failed")
      redirect_to event_path(result.record.event)
    end
  end

  private

  def appointment_params
    params.merge(user_id: current_user.id)
          .permit(:user_id, :event_id, :tickets_amount)
  end
end
