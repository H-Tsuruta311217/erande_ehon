class Book < ApplicationRecord

  belongs_to :member
  has_many   :category_books
  has_many   :categories, through: :category_books
  has_many   :post_comments, dependent: :destroy
  has_many   :post_comment_members, through: :post_comments, source: :member
  has_many   :favorites, dependent: :destroy
  has_many   :favorited_members, through: :favorites, source: :member

  has_one_attached :book_image
  validates        :name,presence: true
  validates        :description,presence: true,length:{maximum: 200}
  validates        :categories, presence: true

  # 絵本画像のサイズ調整
  def get_book_image(width, height)
    unless book_image.attached?
      # 画像がない場合はimages/no-image.jpgを参照
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      item_book.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    book_image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(member)
    #現在ログインしている会員によっていいねされてる？
    favorites.exists?(member_id: member.id)
    #いいねは存在してる？(いいねを既に押してるか、押していないか)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "member_id", "name", "updated_at"]
  end
end
