class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 30 }
  validates :password, presence: true, length: { minimum: 6 }
    # メールアドレスが正しい形式で入力されているかのバリデーション
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    # 大文字小文字を区別するためにすべて小文字として判定するための破壊的メソッドdowncase!
  before_validation { email.downcase! }
  has_secure_password
  has_many :favorites, dependent: :destroy
  # ユーザーはポストに対しても　１対多の関係により、hasmanyが必要という解釈。
  has_many :posts, deoendent: :destroy 
end
