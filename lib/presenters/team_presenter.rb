class TeamPresenter
  attr_reader :team

  def initialize(team)
    @team = team
  end

  def as_json(options={})
    {
      abbreviation: team.abbreviation,
      full_name: team.full_name,
      location: team.location
    }
  end
end
