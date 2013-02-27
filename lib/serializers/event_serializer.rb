require 'serializers/event_summary_serializer'
require 'serializers/basketball/box_score_serializer'

class EventSerializer < EventSummarySerializer
  attributes :share_url,
             :sport_name

  has_one :box_score, serializer: Basketball::BoxScoreSerializer
end
