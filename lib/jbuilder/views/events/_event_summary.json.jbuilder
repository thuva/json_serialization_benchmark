json.(event, :game_date, :game_type, :status)

json.away_team do
  json.partial! 'basketball/teams/team', team: event.away_team
end

json.home_team do
  json.partial! 'basketball/teams/team', team: event.home_team
end
