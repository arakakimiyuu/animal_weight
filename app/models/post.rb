class Post < ApplicationRecord
  belongs_to :customer
  belongs_to :pet
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  #バリデーション
  validates :date, presence: true
  validates :weight, presence: true
  validates :feed, presence: true
  validates :amount_food, presence: true

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

  #ソート機能
  scope :latest, -> {order(created_at: :desc)}  #desc・・・昇順
  scope :old, -> {order(created_at: :asc)} #asc・・・降順
  #orderデータの取り出し
  #Latest,oid任意の名前で定義する

end
