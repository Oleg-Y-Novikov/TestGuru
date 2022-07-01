class CreatePassedTests < ActiveRecord::Migration[6.1]
  def change
    create_table :passed_tests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true
      t.timestamps
    end
    add_index :passed_tests, [:user_id, :test_id], unique: true
  end
end
