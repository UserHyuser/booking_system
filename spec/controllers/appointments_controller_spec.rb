require "rails_helper"

RSpec.describe AppointmentsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event, tickets_available: 10) }

  before do
    allow(Current).to receive(:user).and_return(user)
    allow(Creators::AppointmentCreator).to receive(:call).and_call_original
  end

  describe "POST #create" do
    context "when user is not logged in" do
      before do
        allow(Current).to receive(:user).and_return(nil)
      end

      let(:valid_params) do
        { event_id: event.id, tickets_amount: 5 }
      end

      it "calls the AppointmentCreator" do
        post :create, params: valid_params

        expect(Creators::AppointmentCreator).not_to have_received(:call)
        expect(response).to redirect_to(new_session_path)
        expect(flash[:alert]).to eq(I18n.t("controllers.sessions.user_login_required"))
      end
    end

    context "when creation is successful" do
      let(:valid_params) do
        { event_id: event.id, tickets_amount: 5 }
      end

      it "calls the AppointmentCreator" do
        post :create, params: valid_params
        expect(Creators::AppointmentCreator).to have_received(:call)
      end

      it "redirects to the appointments index page with success notice" do
        post :create, params: valid_params
        expect(response).to redirect_to(appointments_path)
        expect(flash[:notice]).to eq(I18n.t("controllers.appointments.purchase_successful"))
      end

      it "creates a new appointment" do
        expect do
          post :create, params: valid_params
        end.to change(Appointment, :count).by(1)
      end

      it "reduces available tickets" do
        post :create, params: valid_params
        event.reload
        expect(event.tickets_available).to eq(5)
      end
    end

    context "when there are not enough tickets" do
      let(:invalid_params) do
        { event_id: event.id, tickets_amount: 15 }
      end

      it "does not create a new appointment" do
        expect do
          post :create, params: invalid_params
        end.not_to change(Appointment, :count)
      end

      it "redirects to the event page with failure alert" do
        post :create, params: invalid_params
        expect(response).to redirect_to(event_path(event))
        expect(flash[:alert]).to eq(I18n.t("controllers.appointments.purchase_failed"))
      end
    end

    context "when the creator returns an error" do
      before do
        allow(Creators::AppointmentCreator).to receive(:call).and_return(
          double(success?: false, record: build_stubbed(:appointment, event: event))
        )
      end

      it "redirects to the event page with failure message" do
        post :create, params: { event_id: event.id, tickets_amount: 5 }
        expect(response).to redirect_to(event_path(event))
        expect(flash[:alert]).to eq(I18n.t("controllers.appointments.purchase_failed"))
      end
    end
  end

  describe "GET #index" do
    context "when user is not logged in" do
      before do
        allow(Current).to receive(:user).and_return(nil)
      end

      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to(new_session_path)
        expect(flash[:alert]).to eq(I18n.t("controllers.sessions.user_login_required"))
      end
    end

    context "when user is logged in" do
      before do
        allow(Current).to receive(:user).and_return(user)
      end

      it "returns a successful response" do
        get :index
        expect(response).to be_successful
      end
    end
  end
end
