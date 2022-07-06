# frozen_string_literal: true

class CreateTestsUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :tests_users do |t|
      t.references :test, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :tests_users, [:test_id, :user_id], unique: true
  end
end
