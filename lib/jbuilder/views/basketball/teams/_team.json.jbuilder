json.partial! 'teams/team', team: team

json.(team, :medium_name, :short_name)