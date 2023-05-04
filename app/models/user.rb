class User < ApplicationRecord
  has_one_attached :avatar

  has_many :likes, dependent: :destroy
  has_many :tweets, through: :likes, counter_cache: true
end
