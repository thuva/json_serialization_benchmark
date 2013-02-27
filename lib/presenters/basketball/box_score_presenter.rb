require 'presenters/box_score_presenter'
require 'presenters/basketball/play_by_play_record_presenter'

module Basketball
  class BoxScorePresenter < BoxScorePresenter
    def as_json(options={})
      super.merge(
        attendance: box_score.attendance,
        referees: box_score.referees,
        last_play: Basketball::PlayByPlayRecordPresenter.new(box_score.last_play).as_json
      )
    end
  end
end
