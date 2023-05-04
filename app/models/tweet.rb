class Tweet < ApplicationRecord
  # Validations
  validates :body, presence:true, allow_blank: false,  length: { maximun: 140 }
  validates :username, presence: true, uniqueness: true, allow_blank: false
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, allow_blank: false
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :password, presence: true, length: { minimun: 6 }
  
  # Associations
  belongs_to :user
  belongs_to :replied_to
  
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes


end
