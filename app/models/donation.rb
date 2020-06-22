class Donation < ApplicationRecord

  # tweets-------------------------------------------------------------------
  belongs_to :tweet
# users-------------------------------------------------------------------
  belongs_to :user

  validates :amount, presence: true, numericality: { greater_than: 0 }
  
end
