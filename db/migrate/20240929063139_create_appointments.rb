class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :user, index: true
      t.references :event

      t.integer :tickets_amount

      t.timestamps
    end
  end
end
