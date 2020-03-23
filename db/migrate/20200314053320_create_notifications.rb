class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true, null: false
      t.boolean :read_flag, default: false
      t.string :link_type
      t.string :link_option
      t.string :description

      t.timestamps
    end
  end
end
