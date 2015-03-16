json.partial! 'box_scores/box_score', box_score: box_score

json.(box_score, :attendance, :referees)

json.last_play do
  json.partial! 'basketball/play_by_play_records/play_by_play_record', play_by_play_record: box_score.last_play
end
