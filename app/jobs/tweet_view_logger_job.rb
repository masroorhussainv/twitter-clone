class TweetViewLoggerJob < ApplicationJob
  queue_as :default

  def perform(tweet:, user:)
    TweetViewLogger.new(tweet, user).execute
  end
end
