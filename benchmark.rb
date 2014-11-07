$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))

require 'bixby/bench'
require 'json_serialization_benchmark'

require 'serializers/event_summary_serializer'
require 'serializers/team_serializer'
require 'serializers/basketball/event_serializer'

require 'presenters/event_summary_presenter'
require 'presenters/team_presenter'
require 'presenters/basketball/event_presenter'

require 'oj'
Oj.mimic_JSON() # this will speedup benchmarks using #to_json
require 'find'
require 'api_view/api_view'

module SerializationBenchmark

  # load api_view models

  Find.find(File.expand_path(File.dirname(__FILE__) + '/lib/api_view/views')) do |path|
    next if not File.file? path
    require path
  end

  collection_size = 100
  rabl_view_path  = File.expand_path(File.dirname(__FILE__) + '/lib/rabl/views')

  event = EventFactory.build_event
  team  = event.home_team

  event_collection = collection_size.times.map { event }
  team_collection  = collection_size.times.map { team }

  Bixby::Bench.run(10_000) do |b|

    # ULTRA SIMPLE
    b.sample('RABL Ultra Simple') do
      Rabl.render(team, 'teams/item', view_path: rabl_view_path, format: :json)
    end

    b.sample('AMS Ultra Simple') do
      JsonEncoder.dump(TeamSerializer.new(team).to_json)
    end

    b.sample('Presenters Ultra Simple') do
      JsonEncoder.dump(TeamPresenter.new(team).to_json)
    end

    b.sample('ApiView Ultra Simple') do
      ApiView::Engine.render(team, nil, :format => "json")
    end


    # SIMPLE
    b.divider

    b.report('RABL Simple') do
      Rabl.render(event, 'events/item', view_path: rabl_view_path, format: :json)
    end

    b.report('AMS Simple') do
      JsonEncoder.dump(EventSummarySerializer.new(event).to_json)
    end

    b.report('Presenters Simple') do
      JsonEncoder.dump(EventSummaryPresenter.new(event).to_json)
    end

    b.report('ApiView Simple') do
      ApiView::Engine.render(event, nil, :format => "json", :use => EventSummaryApiView)
    end


    # COMPLEX
    b.divider

    b.report('RABL Complex') do
      Rabl.render(event, 'basketball/events/show', view_path: rabl_view_path, format: :json)
    end

    b.report('AMS Complex') do
      JsonEncoder.dump(Basketball::EventSerializer.new(event).to_json)
    end

    b.report('Presenters Complex') do
      JsonEncoder.dump(Basketball::EventPresenter.new(event).to_json)
    end

    b.report('ApiView Complex') do
      ApiView::Engine.render(event, nil, :format => "json", :use => BasketballEventApiView)
    end
  end


  # COLLECTION TESTS
  puts "\n\nCollection tests:\n\n"

  Bixby::Bench.run(100) do |b|

    # ULTRA SIMPLE
    b.report('RABL Ultra Simple: Collection') do
      Rabl.render(team_collection, 'teams/index', view_path: rabl_view_path, format: :json)
    end

    b.report('AMS Ultra Simple: Collection') do
      result = ActiveModel::ArraySerializer.
        new(team_collection, each_serializer: TeamSerializer).
        as_json

      JsonEncoder.dump(result)
    end

    b.report('Presenters Ultra Simple: Collection') do
      result = team_collection.map { |team| TeamPresenter.new(team).as_json }
      JsonEncoder.dump(result)
    end

    b.report('ApiView Ultra Simple: Collection') do
      ApiView::Engine.render(team_collection, nil, :format => "json")
    end


    # SIMPLE
    b.divider

    b.report('RABL Simple: Collection') do
      Rabl.render(event_collection, 'events/index', view_path: rabl_view_path, format: :json)
    end

    b.report('AMS Simple: Collection') do
      result = ActiveModel::ArraySerializer.
        new(event_collection, each_serializer: EventSummarySerializer).
        as_json

      JsonEncoder.dump(result)
    end

    b.report('Presenters Simple: Collection') do
      result = event_collection.map { |event| EventSummaryPresenter.new(event).as_json }
      JsonEncoder.dump(result)
    end

    b.report('ApiView Simple: Collection') do
      ApiView::Engine.render(event_collection, nil, :format => "json", :use => EventSummaryApiView)
    end


    # COMPLEX
    b.divider

    b.report('RABL Complex: Collection') do
      Rabl.render(event_collection, 'basketball/events/index', view_path: rabl_view_path, format: :json)
    end

    b.report('AMS Complex: Collection') do
      result = ActiveModel::ArraySerializer.
        new(event_collection, each_serializer: Basketball::EventSerializer).
        as_json

      JsonEncoder.dump(result)
    end

    b.report('Presenters Complex: Collection') do
      result = event_collection.map { |event| Basketball::EventPresenter.new(event).as_json }
      JsonEncoder.dump(result)
    end

    b.report('ApiView Complex: Collection') do
      ApiView::Engine.render(event_collection, nil, :format => "json", :use => BasketballEventApiView)
    end

  end

end
