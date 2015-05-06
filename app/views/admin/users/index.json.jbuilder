json.array!(@users) do |user|
  json.extract! user, :first_name, :last_name, :stars, :description, :pesel, :address_1, :address_2, :school, :school_class, :parental_agreement, :medical_info, :team_id
  json.url user_url(user, format: :json)
end