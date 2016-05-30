class AddReserveDateToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :pre_start_date, :datetime
    add_column :schedules, :pre_end_date, :datetime
  end
end
