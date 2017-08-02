require 'rails_helper'

RSpec.describe User, type: :model do
  context "with valid attributes" do
    it "should save" do
      expect(build(:user)).to be_valid
    end

    it 'automatically encrypts the password into the password_digest attribute' do
      expect(build(:user).password_digest.present?).to eq(true)
    end

    it 'email as lowercase'do
      expect(create(:user,email:"EMAIL@GMAIL.COM").convert_email_lowercase).to eq('email@gmail.com')
    end
  end

  context "with invalid attributes" do
    it "email is blank" do
      expect(build(:user, email: '')).to be_invalid
    end

    it "name is blank" do
      expect(build(:user, name: '')).to be_invalid
    end

    it "email format is wrong" do
      emails_list = ['d1', '@hdjfh', '.com']
      emails_list.each do |email|
        expect(build(:user, email: email)).to be_invalid
      end
    end

    it "email format is right" do
      emails_list = ['deepti@gmail.com', 'dv@yahoo.com']
      emails_list.each do |email|
        expect(build(:user, email: email)).to be_valid
      end
    end

    it "password is blank" do
      expect(build(:user, password: '')).to be_invalid
    end

    it "password doesnt match password confirmation" do
      expect(build(:user,password: 'deepti', password_confirmation: 'another')).to be_invalid
    end

    it "email uniqueness checked" do
      create(:user)
      expect(build(:user)).to  be_invalid
    end
  end

context "relationships" do
  before do
    @user = create(:user)
    @secret = create(:secret,content:"Hello", user: @user)
    @like = create(:like, user: @user, secret: @secret)
  end

  it "has secrets" do
    expect(@user.secrets).to include(@secret)
  end

  it "has likes" do
    expect(@user.likes).to include(@like)
  end

  it "has secrets through like table" do
    expect(@user.secrets_liked).to include(@secret)
  end  

end

end
