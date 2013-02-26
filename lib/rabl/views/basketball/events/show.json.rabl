extends 'events/show'

code(:away_ranking, if: ->(event) { event.ncaa? }) do |event|
  event.away_ranking
end

code(:away_region, if: ->(event) { event.ncaa? }) do |event|
  event.away_region
end

code(:home_ranking, if: ->(event) { event.ncaa? }) do |event|
  event.home_ranking
end

code(:home_region, if: ->(event) { event.ncaa? } ) do |event|
  event.home_region
end

attribute :important
attribute :location
