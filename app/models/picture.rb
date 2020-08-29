class Picture < ApplicationRecord
  mount_uploader :image, PictureImageUploader
  validates :image, presence: true
  validates :content, presence: true
end
