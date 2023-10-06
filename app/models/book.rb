class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :member
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_members, through: :favorites, source: :user

  validates :name,presence: true
  validates :description,presence: true,length:{maximum: 200}
  validates :category, presence: true

  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
end
