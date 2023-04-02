class ResetAllTweetCounterCache < ActiveRecord::Migration[7.0]
  def up
    Tweet.all.each do |tweet|
      Tweet.reset_counters(tweet.id, :likes)
    end
  end

  def down;end
end
