require 'presenters/team_presenter'

module Basketball
  class TeamPresenter < TeamPresenter
    def as_json(options={})
      super.merge(
        medium_name: team.medium_name,
        short_name: team.short_name
      )
    end
  end
end
