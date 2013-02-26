extends 'events/item'

attributes :share_url,
           :sport_name

child(box_score: :box_score) do
  extends 'basketball/box_scores/show'
end
