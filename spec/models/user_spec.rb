require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tweets).dependent(:destroy) }
  it { should validate_uniqueness_of(:username).case_insensitive.allow_blank}

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
