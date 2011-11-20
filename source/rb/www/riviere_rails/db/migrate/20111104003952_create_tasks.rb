class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
	t.string :alignment_sequence
	t.string :base_sequence1
	t.string :base_sequence2
	t.string :uid
      	t.timestamps
    end
  end
end
