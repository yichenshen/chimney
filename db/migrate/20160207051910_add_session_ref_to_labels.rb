class AddSessionRefToLabels < ActiveRecord::Migration
  def change
    add_reference :labels, :session, index: true, foreign_key: true
    add_foreign_key :labels, :sessions, dependent: :delete
  end
end
