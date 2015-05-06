json.array!(@teams) do |team|
  json.extract! team, :name, :history, :situation_description
  json.url team_url(team, format: :json)
end