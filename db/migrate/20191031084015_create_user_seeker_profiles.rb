class CreateUserSeekerProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_seeker_profiles do |t|
      t.references :seeker, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
