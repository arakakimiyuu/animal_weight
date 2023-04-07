class Post < ApplicationRecord
  belongs_to :customer
  belongs_to :pet
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  def favorited_by?(current_customer)
    favorites.exists?(customer_id: customer.id)
  end

end
