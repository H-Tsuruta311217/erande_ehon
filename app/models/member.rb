class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :last_name,   presence: true, length: {maximum: 20}
  validates :first_name,  presence: true, length: {maximum: 20}
  validates :nickname,    presence: true, length: {maximum: 20}
  validates :introduction, presence: false, length: { maximum: 50 } # 自己紹介の最高文字数は50文字

  def self.guest
    find_or_create_by(email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.last_name = "ゲスト"
      member.first_name = "ユーザー"
      member.nickname = "ゲスト"
    end
  end

  def active_for_authentication?
    super && (is_active == true)
  end
end
