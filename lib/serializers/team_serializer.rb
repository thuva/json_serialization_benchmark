class TeamSerializer < ActiveModel::Serializer
  attributes :abbreviation,
             :full_name,
             :location
end
