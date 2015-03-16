json.partial! 'events/event', event: event

json.(event, :important, :location)

if event.ncaa?
  json.(event, :away_ranking, :away_region, :home_ranking, :home_region)
end
