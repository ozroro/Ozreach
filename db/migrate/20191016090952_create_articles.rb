class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :recruiter_articles do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
