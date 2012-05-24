class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.integer :type #0-folowers; 1-you follow; 2 - friends

      t.timestamps
    end
  end
end
