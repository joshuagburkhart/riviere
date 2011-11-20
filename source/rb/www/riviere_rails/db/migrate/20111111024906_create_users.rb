class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :lname
      t.string :fname
      t.string :email
      t.string :pswd
      t.string :organization
      t.string :org_address
      t.string :org_pcode
      t.string :activesess
      t.timestamps
    end
  end
end
