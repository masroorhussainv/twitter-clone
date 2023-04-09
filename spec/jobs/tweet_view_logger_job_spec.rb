require 'rails_helper'

RSpec.describe TweetViewLoggerJob, type: :job do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet) }

  subject { described_class.new.perform(tweet: tweet, user: user) }

  it "creates a view record when tweet is not viewed by the user" do
    expect { subject }.to change { View.count }.by(1)
  end

  it "does not create a view record when tweet has been already viewed by the user" do
    create(:view, tweet: tweet, user: user)
    expect { subject }.not_to change { View.count }
  end
end
