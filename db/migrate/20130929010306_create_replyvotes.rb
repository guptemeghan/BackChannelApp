class CreateReplyvotes < ActiveRecord::Migration
  def change
    create_table :replyvotes do |t|
      t.string :studentid
      t.references :replyvotes
      t.timestamps
    end
  end
end
