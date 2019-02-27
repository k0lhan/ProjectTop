class Post < ApplicationRecord
  belongs_to :user

  mount_uploaders :photos, PhotoUploader
  serialize :photos, JSON # If you use SQLite, add this line.
end
