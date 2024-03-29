class Listing < ActiveRecord::Base
  if Rails.env.development?
    has_attached_file :image, :style => {:medium => "200x", :thumb => "100x100" }, :default_url => "default.jpg"
  else
    has_attached_file :image, :style => {:medium => "200x", :thumb => "100x100" }, :default_url => "default.jpg",
                    :storage => :dropbox,
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                    :path => ":style/:id_:filename"
  end

  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  belongs_to :user
  # A listing can have many orders
  has_many :orders
end
