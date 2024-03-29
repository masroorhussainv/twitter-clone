require 'rails_helper'

RSpec.describe TweetPresenter, type: :presenter do
  describe "#created_at" do
    let(:user) { create(:user) }

    context 'when 24 hours have passed' do
      before do
        travel_to Time.local(2008,9,3,10,5,0)
      end

      after do
        travel_back
      end

      it 'displays shorthand format' do
        tweet = create(:tweet)
        tweet.update(created_at: 2.days.ago)
        expect(TweetPresenter.new(tweet, current_user: user).created_at).to eql('Sep 1')
      end
    end

    context 'before a full day has passed' do
      it 'displays how many hours have passed' do
        tweet= create(:tweet)
        tweet.update!(created_at: 3.hours.ago)
        expect(TweetPresenter.new(tweet, current_user: user).created_at).to eq('about 3 hours')
      end
    end
  end
end