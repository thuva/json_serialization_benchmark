require 'serializers/team_serializer'

module Basketball
  class TeamSerializer < TeamSerializer
    attributes :medium_name,
               :short_name
  end
end
