require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:likes).dependent(:destroy) }
  # it { should validate_presence_of(:body).is_at_most(280) }
  it { should validate_presence_of(:body) }
end
