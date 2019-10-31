class CreateUserRecruiterProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_recruiter_profiles do |t|
      t.references :recruiter, foreign_key: true
      t.string :corporate_name
      t.text :content

      t.timestamps
    end
  end
end
