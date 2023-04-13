class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  #バリデーション
  validates :comment, presence: true
end
