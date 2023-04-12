class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pets, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  # is_deletedがfalseならtrueを返すようにしている
  #ログイン時に退会済みのユーザーが同じアカウントでログイン出来ないよう制約を設けています
  def active_for_authentication?
    super && (is_delete == false)
  end

  #ゲストのemailでデータベースから検索してあればレコードを使用なければパスワード、名前を追加して登録
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "guest"
    end
  end

  #ゲストか判断する
  def guest?
    if self.email == 'guest@example.com'
      true
    else
      false
    end
  end
y
end
