class CreateUserBases < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
