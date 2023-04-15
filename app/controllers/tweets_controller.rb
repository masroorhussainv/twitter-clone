class TweetsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))

    if @tweet.save
      respond_to do |format|
        format.html{ redirect_to dashboard_path }
        format.turbo_stream
      end
    end
  end

  def show
    TweetViewLoggerJob.perform_later(tweet: tweet, user: current_user)
    @tweet_presenter = TweetPresenter.new(tweet, current_user: current_user)
    @reply_tweets_in_presenter =  tweet.reply_tweets
                                       .includes(:liked_users, :user, :retweeted_users, :bookmarked_users)
                                       .descending
                                       .map{|tweet| TweetPresenter.new(tweet, current_user: current_user) }
  end

  private

  def tweet
    @tweet ||= Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end