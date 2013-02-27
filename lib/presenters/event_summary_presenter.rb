require 'presenters/basketball/team_presenter'

class EventSummaryPresenter
  attr_reader :event

  def initialize(event)
    @event = event
  end

  def as_json(options={})
    {
      game_date: event.game_date,
      game_type: event.game_type,
      status: event.status,
      away_team: Basketball::TeamPresenter.new(event.away_team).as_json,
      home_team: Basketball::TeamPresenter.new(event.home_team).as_json
    }
  end
end
