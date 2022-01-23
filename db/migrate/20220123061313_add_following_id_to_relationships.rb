class AddFollowingIdToRelationships < ActiveRecord::Migration[6.1]
  def change
    add_column :relationships, :following_id, :integer
  end
end
