class Message < ApplicationRecord

    belongs_to :user
    belongs_to :room

    validates :message, presence: true

    has_many :notifications, dependent: :destroy

    
end
