class User < ApplicationRecord
  has_secure_password
  has_many :secrets
  has_many :likes , dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret

  VALID_EMAIL_REGEX = /[A-Z0-9._-]+@[A-Z]+\.[A-Z]{2,7}/i

  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false}

  def convert_email_lowercase
    email.downcase
  end

end
