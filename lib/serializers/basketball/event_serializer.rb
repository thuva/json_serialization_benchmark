require 'serializers/event_serializer'

module Basketball
  class EventSerializer < EventSerializer
    attributes :away_ranking,
               :away_region,
               :home_ranking,
               :home_region,
               :important,
               :location

    def include_away_ranking?
      object.ncaa?
    end

    def include_away_region?
      object.ncaa?
    end

    def include_home_ranking?
      object.ncaa?
    end

    def include_home_region?
      object.ncaa?
    end
  end
end
