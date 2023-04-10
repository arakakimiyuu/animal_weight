class Post < ApplicationRecord
  belongs_to :customer
  belongs_to :pet
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

　#検索機能
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("feed LIKE?", "#{word}")
    elsif search == "forward_match"
      @post = Post.where("feed LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("feed LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("feed LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

end
