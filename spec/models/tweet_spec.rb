require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it { should belong_to(:user) }

  it { should belong_to(:parent_tweet).with_foreign_key(:parent_tweet_id).class_name('Tweet').optional }

  it { should have_many(:reply_tweets).with_foreign_key(:parent_tweet_id).class_name('Tweet') }

  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_users).through(:likes) }

  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:bookmarked_users).through(:bookmarks).source(:user) }

  it { should have_many(:retweets).dependent(:destroy) }
  it { should have_many(:retweeted_users).through(:retweets).source(:user)}

  it { should have_many(:views).dependent(:destroy) }
  it { should have_many(:viewed_tweets).through(:views).source(:tweet) }

  # it { should validate_presence_of(:body).is_at_most(280) }
  it { should validate_presence_of(:body) }
end
