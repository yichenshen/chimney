class AddDeadlineToErrand < ActiveRecord::Migration
  def change
    add_column :errands, :deadline, :date
  end
end
