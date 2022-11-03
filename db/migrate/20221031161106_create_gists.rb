class CreateGists < ActiveRecord::Migration[6.1]
  def change
    create_table :gists do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :question, null: false, foreign_key: true, index: true
      t.string :gist_id, null: false
      t.string :gist_url, null: false

      t.timestamps
    end
    add_index :gists, [:user_id, :question_id], unique: true
  end
end
