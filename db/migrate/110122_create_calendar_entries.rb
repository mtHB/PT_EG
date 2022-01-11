class CreateCalendarEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :calendar_entries do |t|
      t.integer :user_id, null: false
      t.integer :state, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false

      t.timestamps
    end
  end
end
