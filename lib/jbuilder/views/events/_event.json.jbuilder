json.partial! 'events/event_summary', event: event

json.(event, :share_url, :sport_name)

json.box_score do
  json.partial! 'basketball/box_scores/box_score', box_score: event.box_score
end
