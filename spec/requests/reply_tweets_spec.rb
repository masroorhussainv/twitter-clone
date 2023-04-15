require 'rails_helper'

RSpec.describe "ReplyTweets", type: :request do
  describe "POST create" do
    it "creates a reply tweet" do
      parent_tweet = create :tweet
      user = create :user
      sign_in user
      expect do
        post tweet_reply_tweets_path(parent_tweet), params: { tweet: { body: 'foobar tweet' } }
      end.to change { parent_tweet.reply_tweets.count }.by(1)
      expect(response).to redirect_to(dashboard_path)
    end
  end
end
