class Auction < ApplicationRecord

  validates :price, presence: true

  belongs_to :user
  belongs_to :post
end
