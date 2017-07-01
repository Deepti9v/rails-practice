class User < ActiveRecord::Base
  has_attached_file :photo , styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :name, :occupation, presence: true
end
