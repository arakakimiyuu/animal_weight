class Post < ApplicationRecord
  belongs_to :customer
  belongs_to :pet
end