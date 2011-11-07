class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
	t.integer :id
	t.string :alignment_sequence
	t.string :base_sequence1
	t.string :base_sequence2
      t.timestamps
    end
  end
end
