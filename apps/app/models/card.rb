class Card < ApplicationRecord
    belongs_to:user
    validates :title, :category, :comments, :views, :user_id, presence: true
end
