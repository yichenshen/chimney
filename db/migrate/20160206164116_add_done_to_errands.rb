class AddDoneToErrands < ActiveRecord::Migration
  def change
    add_column :errands, :done, :boolean, :default => false
  end
end
