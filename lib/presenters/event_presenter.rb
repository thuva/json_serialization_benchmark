require 'presenters/event_summary_presenter'
require 'presenters/basketball/box_score_presenter'

class EventPresenter < EventSummaryPresenter
  def as_json(options={})
    super.merge(
      share_url: event.share_url,
      sport_name: event.sport_name,
      box_score: Basketball::BoxScorePresenter.new(event.box_score).as_json
    )
  end
end
