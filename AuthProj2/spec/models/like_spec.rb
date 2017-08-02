require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'relationships' do
    before do
      @user = create(:user)
      @secret = create(:secret, user: @user)
      @like = create(:like, secret: @secret, user: @user)
    end

    it 'belongs to a user' do
      expect(@like.user).to eq(@user)
    end

    it 'belongs to a secret' do
      expect(@secret.user).to eq(@user)
    end

  end
end
