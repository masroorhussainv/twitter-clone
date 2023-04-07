require 'rails_helper'

RSpec.describe "Retweets", type: :request do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet) }

  before do
    sign_in user
  end

  describe "POST create" do
    it "should retweet a tweet" do
      expect do
        post tweet_retweets_path(tweet)
      end.to change{ user.retweets.count }.by(1)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "DELETE destroy" do
    it "should undo the retweet" do
      retweet = create(:retweet, user: user, tweet: tweet)
      expect do
        delete tweet_retweet_path(tweet, retweet)
      end.to change{ user.retweets.count }.by(-1)
      expect(response).to have_http_status(:redirect)
    end
  end
end
