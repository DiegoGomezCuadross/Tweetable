class CreateTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets do |t|
      t.text :body
      t.integer :replies_count, default: 0
      t.integer :likes_count, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :replied_to, null: true, foreign_key: {to_table: :tweets}, numericality: { only_integer: true, greater_than: 0 }

      t.timestamps
    end
    add_index :tweets, unique: true
  end
end
