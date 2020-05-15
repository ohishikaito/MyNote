class Tweet < ApplicationRecord

  mount_uploader :image, ImageUploader
end
