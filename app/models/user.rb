class User < ApplicationRecord
  before_save { self.emall = emall.downcase }
  validate :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :emall, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMALL_REGEX },
                    uniqueness: { case_sensitive: false },
	has_secure_password
  validates :password, presence: true, length: {minimum: 6 }
end