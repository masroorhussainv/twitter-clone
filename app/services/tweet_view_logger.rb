class TweetViewLogger
  attr_reader :tweet, :current_user

  def initialize(tweet, current_user)
    @tweet = tweet
    @current_user = current_user
  end

  def execute
    return if View.exists?(tweet: tweet, user: current_user)

    View.create(tweet: tweet, user: current_user)
  end
end