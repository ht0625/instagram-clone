class Picture < ApplicationRecord
  has_many :favorites, dependent: :destroy
  belongs_to :user
  mount_uploader :image, PictureImageUploader
  validates :image, presence: true
  validates :content, presence: true
end
