class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :introduction
      t.integer :owner_id, null:false

      t.timestamps
    end
  end
end
