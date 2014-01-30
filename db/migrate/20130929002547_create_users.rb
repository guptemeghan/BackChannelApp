class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :studentid
      t.string :name
      t.string :email
      t.string :username
      t.string :password
      t.integer :priority

      t.timestamps
    end
  end
end
