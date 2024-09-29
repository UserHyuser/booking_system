class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.string :location
      t.datetime :datetime
      t.integer :tickets_available

      t.timestamps
    end
  end
end
