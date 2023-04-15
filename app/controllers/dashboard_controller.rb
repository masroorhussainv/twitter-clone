class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tweets = Tweet.includes(:liked_users, :user, :retweeted_users, :bookmarked_users).descending.map { |tweet| TweetPresenter.new(tweet, current_user: current_user) }
  end
end