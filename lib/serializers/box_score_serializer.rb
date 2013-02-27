class BoxScoreSerializer < ActiveModel::Serializer
  attributes :has_statistics,
             :progress
end
