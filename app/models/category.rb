class Category < ApplicationRecord

  has_many :category_books
  has_many :books, through: :category_books
  validates :name, presence:true

  def self.looks(search, word)
    if search == "perfect_match"
      @category = Category.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @category = Category.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @category = Category.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @category = Category.where("name LIKE?","%#{word}%")
    else
      @category = Category.all
    end
  end

end
