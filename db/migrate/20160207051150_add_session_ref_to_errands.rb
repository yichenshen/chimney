class AddSessionRefToErrands < ActiveRecord::Migration
  def change
    add_reference :errands, :session, index: true, foreign_key: true
    add_foreign_key :errands, :sessions, dependent: :delete
  end
end
