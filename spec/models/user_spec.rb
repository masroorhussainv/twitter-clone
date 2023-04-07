require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tweets).dependent(:destroy) }
  it { should validate_uniqueness_of(:username).case_insensitive.allow_blank}

  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_tweets).through(:likes).source(:tweet)}

  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:bookmarked_tweets).through(:bookmarks) }

  it { should have_many(:retweets).dependent(:destroy) }
  it { should have_many(:retweeted_tweets).through(:retweets).source(:tweet)}

  describe "#set_display_name" do
    context "when display name is set" do
      it "does not change the display name" do
        user = create(:user, username: 'masroor', display_name: 'Masroor')
        # user.save
        # expect(user.reload.display_name).to eq('Masroor')
        expect do
          user.save
        end.not_to change { user.reload.display_name }
      end
    end

    context "when display name is not set" do
      it "humanizes previously set username" do
        user = create(:user, username: 'masroor', display_name: nil)
        user.save
        expect(user.reload.display_name).to eq('Masroor')
      end
    end
  end
end
