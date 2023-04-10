class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         #devise.rbで全体的に名前でログインできるように設定したけど,
         #今回は管理者側はメールアドレスで設定したいので個別に書かないとダメ
         :database_authenticatable, authentication_keys: [:email]

end
