class AddLikesCountToTweets < ActiveRecord::Migration[7.0]
  def up
    add_column :tweets, :likes_count, :integer, null:false, default: 0
  end

  def down
    remove_column :tweets, :likes_count
  end
end
