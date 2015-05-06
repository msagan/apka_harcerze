json.array!(@badges) do |badge|
  json.extract! badge, :color, :user_id, :name, :description, :comment
  json.url badge_url(badge, format: :json)
end