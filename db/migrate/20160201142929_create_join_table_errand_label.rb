class CreateJoinTableErrandLabel < ActiveRecord::Migration
  def change
    create_join_table :errands, :labels do |t|
     	t.index [:errand_id, :label_id]
    end
  end
end
