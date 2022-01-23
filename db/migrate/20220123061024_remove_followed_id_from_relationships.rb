class RemoveFollowedIdFromRelationships < ActiveRecord::Migration[6.1]
  def change
    remove_column :relationships, :followed_id, :integer
  end
end
