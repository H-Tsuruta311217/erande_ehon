class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :last_name,   presence: true, length: {maximum: 20}
  validates :first_name,  presence: true, length: {maximum: 20}
  validates :nickname,    presence: true, length: {maximum: 20}

  def self.guest
    find_or_create_by(email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
    end
  end
end
