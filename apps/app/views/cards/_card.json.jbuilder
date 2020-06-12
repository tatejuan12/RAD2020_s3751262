json.extract! card, :id, :title, :topic_id, :comments, :views, :user_id, :created_at, :updated_at
json.url card_url(card, format: :json)
