class Post < ApplicationRecord
  validates :title,  presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 512 }
  validates :image, presence: true
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  mount_uploader :image, ImageUploader
end
