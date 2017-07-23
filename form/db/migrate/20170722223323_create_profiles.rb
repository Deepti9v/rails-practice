class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :location
      t.string :language
      t.text :comment
      t.timestamps
    end
  end
end
