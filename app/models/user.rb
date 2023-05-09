class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
         
  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :name, presence:true, allow_blank: false
  validates :username, presence: true, uniqueness: true, allow_blank: false
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: false

  validates :password, presence: true, length: { minimum: 6 }
  
  # Association
  has_one_attached :avatar

  has_many :likes, dependent: :destroy
  has_many :tweets, through: :likes, counter_cache: true

    def self.from_omniauth(auth_hash)
    # Retorna un usuario si lo encuentra
    # Si no lo encuentra
      # Crea al usuario
      # Luego lo retorna

    where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create do |user|
      user.provider = auth_hash.provider
      user.uid = auth_hash.uid
      user.username = auth_hash.info.name
      user.email = auth_hash.info.email
      user.password = Devise.friendly_token
    end
  end
end
