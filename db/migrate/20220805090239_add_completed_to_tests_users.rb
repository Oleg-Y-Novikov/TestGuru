class AddCompletedToTestsUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :tests_users, :completed, :boolean, default: false
  end
end
