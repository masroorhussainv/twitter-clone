
class TweetPresenter
  include ActionView::Helpers::DateHelper
  include Rails.application.routes.url_helpers

  attr_reader :tweet, :current_user

  delegate :user, :body, :likes, :likes_count, :retweets_count, to: :tweet
  delegate :display_name, :username, :avatar, to: :user

  def initialize(tweet, current_user:)
    @tweet = tweet
    @current_user = current_user
  end

  def created_at
    if (Time.zone.now - tweet.created_at) > 1.day
      tweet.created_at.strftime("%b %-d")
    else
      time_ago_in_words(tweet.created_at)
    end
  end

  def tweet_like_url
    if tweet_liked_by_user?
      tweet_like_path(tweet, current_user.likes.find_by(tweet_id: tweet.id))
    else
      tweet_likes_path(tweet)
    end
  end

  def like_heart_image
    if tweet_liked_by_user?
      'bi bi-heart-fill text-danger'
    else
      'bi bi-heart'
    end
  end

  def turbo_data_method
    if tweet_liked_by_user?
      'delete'
    else
      'post'
    end
  end

  def tweet_bookmark_url
    if tweet_bookmarked_by_current_user?
      tweet_bookmark_path(tweet, current_user.bookmarks.find_by(tweet_id: tweet.id))
    else
      tweet_bookmarks_path(tweet)
    end
  end

  def bookmark_image
    if tweet_bookmarked_by_current_user?
      'bi bi-bookmark-fill text-info'
    else
      'bi bi-bookmark'
    end
  end

  def bookmark_text
    if tweet_bookmarked_by_current_user?
      'Bookmarked'
    else
      'Bookmark'
    end
  end

  def bookmark_turbo_method
    if tweet_bookmarked_by_current_user?
      'delete'
    else
      'post'
    end
  end

  def retweet_url
    if tweet_retweeted_by_current_user?
      tweet_retweet_path(tweet, current_user.retweets.find_by(tweet_id: tweet.id))
    else
      tweet_retweets_path(tweet)
    end
  end

  def retweet_image
    if tweet_retweeted_by_current_user?
      'bi bi-repeat text-info'
    else
      'bi bi-repeat'
    end
  end

  def retweet_turbo_method
    if tweet_retweeted_by_current_user?
      'delete'
    else
      'post'
    end
  end

  private

    def tweet_liked_by_user?
      @tweet_liked_by_current_user ||= tweet.liked_users.include?(current_user)
    end

    def tweet_bookmarked_by_current_user?
      @tweet_bookmarked_by_current_user ||= tweet.bookmarked_users.include?(current_user)
    end

    def tweet_retweeted_by_current_user?
      @tweet_retweeted_by_current_user ||= tweet.retweeted_users.include?(current_user)
    end
end