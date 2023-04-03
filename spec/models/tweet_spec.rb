require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_users).through(:likes) }

  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:bookmarked_users).through(:bookmarks).source(:user) }

  # it { should validate_presence_of(:body).is_at_most(280) }
  it { should validate_presence_of(:body) }
end
