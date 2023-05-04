class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

 validates :user, uniqueness: { scope: :tweet, message: "and Tweet combination already taken" }
end
