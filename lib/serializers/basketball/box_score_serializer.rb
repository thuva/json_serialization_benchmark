require 'serializers/box_score_serializer'
require 'serializers/basketball/play_by_play_record_serializer'

module Basketball
  class BoxScoreSerializer < BoxScoreSerializer
    attributes :attendance,
               :referees

    has_one :last_play, serializer: Basketball::PlayByPlayRecordSerializer
  end
end
