class Post < ApplicationRecord
  validates :title, presence: true
  validates :sentence, presence: true


  belongs_to :user
  has_many :auctions
  
  has_one_attached :image
end
