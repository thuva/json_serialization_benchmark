attributes :game_date,
           :game_type,
           :status

child(away_team: :away_team) do
  extends 'basketball/teams/item'
end

child(home_team: :home_team) do
  extends 'basketball/teams/item'
end
