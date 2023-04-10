class Pet < ApplicationRecord
  belongs_to :customer
   has_one_attached :image

   def get_profile_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width, height]).processed
   end

  def self.looks(search, word)
    if search == "perfect_match"
      @pet = Pet.where("pet_type LIKE?", "#{word}")
    elsif search == "forward_match"
      @pet = Pet.where("pet_type LIKE?","#{word}%")
    elsif search == "backward_match"
      @pet = Pet.where("pet_type LIKE?","%#{word}")
    elsif search == "partial_match"
      @pet = Pet.where("pet_type LIKE?","%#{word}%")
    else
      @pet = Pet.all
    end
  end

  #enum の定義
  enum gender: { male: 0, female: 1, unknown: 2 }

end
