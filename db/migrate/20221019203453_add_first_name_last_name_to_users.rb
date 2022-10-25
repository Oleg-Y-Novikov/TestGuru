class AddFirstNameLastNameToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :name, :first_name
    add_column :users, :last_name, :string, null: false
  end
end
