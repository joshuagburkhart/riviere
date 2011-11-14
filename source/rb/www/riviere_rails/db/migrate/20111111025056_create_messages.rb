class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :email
      t.text :msg
      t.string :uid
      t.timestamps
    end
  end
end
