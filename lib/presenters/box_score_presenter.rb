class BoxScorePresenter
  attr_reader :box_score

  def initialize(box_score)
    @box_score = box_score
  end

  def as_json(options={})
    {
      has_statistics: box_score.has_statistics,
      progress: box_score.progress
    }
  end
end
