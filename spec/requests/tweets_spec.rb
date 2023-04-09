require 'rails_helper'

RSpec.describe "Tweets", type: :request do

  describe "POST create" do
    context "when not signed in" do
      it "it responds with a redirect" do
        post tweets_path, params: { tweet: { body: 'Tweet, tweet!' } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when signed in" do
      it "creates a new tweet" do
        user = create(:user)
        sign_in user
        expect do
          post tweets_path, params: {
            tweet: { body: 'Tweet, tweet!!' }
          }
        end.to change { Tweet.count }.by 1
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end

  describe "GET show" do
    let(:user)  { create(:user)  }
    let(:tweet) { create(:tweet) }

    before do
      sign_in user
    end

    it "shows the tweet" do
      tweet = create(:tweet)
      get tweet_path(tweet)
      expect(response).to have_http_status(:success)
    end

    it "increments the view count if tweet not viewed" do
      expect do
        get tweet_path(tweet)
      end.to change { user.views.count }.by(1)
    end

    it "does not increment the view count for already viewed tweet" do
      create(:view, tweet: tweet, user: user)
      expect do
        get tweet_path(tweet)
      end.not_to change { user.views.count }
    end
  end
end