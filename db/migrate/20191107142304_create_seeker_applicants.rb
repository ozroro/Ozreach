class CreateSeekerApplicants < ActiveRecord::Migration[5.2]
  def change
    create_table :seeker_applicants do |t|
      t.references :user, foreign_key: true
      t.references :recruiter_article, foreign_key: true

      t.timestamps
    end
  end
end
