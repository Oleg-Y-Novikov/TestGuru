class AddColumnsToTestsUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :tests_users, :current_question, foreign_key: { to_table: :questions }
    add_column :tests_users, :correct_questions, :integer, default: 0
  end
end
