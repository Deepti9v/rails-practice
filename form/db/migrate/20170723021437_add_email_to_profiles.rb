class AddEmailToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :email, :string
  end
end
