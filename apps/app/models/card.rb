class Card < ApplicationRecord
    belongs_to:user
    has_one:topic
    validates :title, :category, :comments, :views, :user_id, presence: true
end
