# frozen_string_literal: true

class Author < ApplicationRecord
  has_secure_password
  acts_as_voter
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  before_save { self.email = email.downcase }
  before_create :set_confirmation_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
  /x.freeze
  validates :password, presence: true, length: { minimum: 8 }, format: { with: PASSWORD_FORMAT }

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def set_confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  private

  def validate_email
    self.email_confirmed = true
    self.confirm_token = nil
      # save!(validate: false )
  end


end
