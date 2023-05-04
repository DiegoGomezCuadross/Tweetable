class User < ApplicationRecord
  # Validations
  validates :name, presence:true, allow_blank: false
  validates :username, presence: true, uniqueness: true, allow_blank: false
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, allow_blank: false
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :password, presence: true, length: { minimun: 6 }
  

  # Association
  has_one_attached :avatar

  has_many :likes, dependent: :destroy
  has_many :tweets, through: :likes, counter_cache: true
end
