class CreateBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :branches do |t|
      t.string :branch
      t.string :street
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
