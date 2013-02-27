require 'serializers/basketball/team_serializer'

class EventSummarySerializer < ActiveModel::Serializer
  attributes :game_date,
             :game_type,
             :status

  has_one :away_team, serializer: Basketball::TeamSerializer
  has_one :home_team, serializer: Basketball::TeamSerializer
end
