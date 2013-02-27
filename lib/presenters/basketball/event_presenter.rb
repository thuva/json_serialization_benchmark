require 'presenters/event_presenter'

module Basketball
  class EventPresenter < EventPresenter

    def as_json(options={})
      attributes = super.merge(
        important: event.important,
        location: event.location
      )

      attributes.tap do |result|
        result.merge!(
          away_ranking: event.away_ranking,
          away_region: event.away_region,
          home_ranking: event.home_ranking,
          home_region: event.home_region
        ) if event.ncaa?
      end
    end

  end
end
