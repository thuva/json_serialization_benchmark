extends 'box_scores/show'

attributes :attendance,
           :referees

child(last_play: :last_play) do
  extends 'basketball/play_by_play_records/show'
end
