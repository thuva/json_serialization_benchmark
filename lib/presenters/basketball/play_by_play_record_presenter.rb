module Basketball
  class PlayByPlayRecordPresenter
    attr_reader :play_by_play_record

    def initialize(play_by_play_record)
      @play_by_play_record = play_by_play_record
    end

    def as_json(options={})
      {
        points_type: play_by_play_record.points_type,
        player_fouls: play_by_play_record.player_fouls,
        player_score: play_by_play_record.player_score,
        record_type: play_by_play_record.record_type,
        seconds: play_by_play_record.seconds
      }
    end
  end
end
