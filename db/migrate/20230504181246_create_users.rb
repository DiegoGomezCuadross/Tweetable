class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :name
      t.string :password
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
