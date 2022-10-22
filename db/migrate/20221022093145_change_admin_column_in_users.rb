class ChangeAdminColumnInUsers < ActiveRecord::Migration[6.1]
  def up
    rename_column :users, :admin, :type
    change_column :users, :type,  :string, default: 'User', null: false
    add_index     :users, :type
  end

  def down
    remove_index  :users, :type
    rename_column :users, :type, :admin
    change_column :users, :admin, :boolean, default: false, null: true
  end
end
