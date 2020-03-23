class AddStatusToSeekerApplicant < ActiveRecord::Migration[5.2]
  def change
    add_column :seeker_applicants, :status, :int,  null: false, default: 0
  end
end
