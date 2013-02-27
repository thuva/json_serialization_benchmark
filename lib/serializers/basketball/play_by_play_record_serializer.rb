module Basketball
  class PlayByPlayRecordSerializer < ActiveModel::Serializer
    attributes :points_type,
               :player_fouls,
               :player_score,
               :record_type,
               :seconds
  end
end
