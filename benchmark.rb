$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))

require 'benchmark'
require 'json_serialization_benchmark'

require 'serializers/event_summary_serializer'
require 'serializers/team_serializer'
require 'serializers/basketball/event_serializer'

require 'presenters/event_summary_presenter'
require 'presenters/team_presenter'
require 'presenters/basketball/event_presenter'

module SerializationBenchmark
  collection_size = 100
  rabl_view_path  = File.expand_path(File.dirname(__FILE__) + '/lib/rabl/views')

  event = EventFactory.build_event
  team  = event.home_team

  event_collection = collection_size.times.map { event }
  team_collection  = collection_size.times.map { team }

  Benchmark.benchmark(Benchmark::CAPTION, 40) do |b|
    sample_size  = 10_000
    divider_size = 86

    b.report('RABL Ultra Simple') do
      sample_size.times do
        Rabl.render(team, 'teams/item', view_path: rabl_view_path, format: :json)
      end
    end

    b.report('AMS Ultra Simple') do
      sample_size.times do
        TeamSerializer.new(team).to_json
      end
    end

    b.report('Presenters Ultra Simple') do
      sample_size.times do
        TeamPresenter.new(team).to_json
      end
    end

    puts '-' * divider_size

    b.report('RABL Simple') do
      sample_size.times do
        Rabl.render(event, 'events/item', view_path: rabl_view_path, format: :json)
      end
    end

    b.report('AMS Simple') do
      sample_size.times do
        EventSummarySerializer.new(event).to_json
      end
    end

    b.report('Presenters Simple') do
      sample_size.times do
        EventSummaryPresenter.new(event).to_json
      end
    end

    puts '-' * divider_size

    b.report('RABL Complex') do
      sample_size.times do
        Rabl.render(event, 'basketball/events/show', view_path: rabl_view_path, format: :json)
      end
    end

    b.report('AMS Complex') do
      sample_size.times do
        Basketball::EventSerializer.new(event).to_json
      end
    end

    b.report('Presenters Complex') do
      sample_size.times do
        Basketball::EventPresenter.new(event).to_json
      end
    end
  end

  puts "\n\n"

  Benchmark.benchmark(Benchmark::CAPTION, 40) do |b|
    sample_size  = 100
    divider_size = 86

    b.report('RABL Ultra Simple: Collection') do
      sample_size.times do
        Rabl.render(team_collection, 'teams/index', view_path: rabl_view_path, format: :json)
      end
    end

    b.report('AMS Ultra Simple: Collection') do
      sample_size.times do
        ActiveModel::ArraySerializer.new(team_collection, each_serializer: TeamSerializer).to_json
      end
    end

    b.report('Presenters Ultra Simple: Collection') do
      sample_size.times do
        team_collection.map { |team| TeamPresenter.new(team).as_json }.to_json
      end
    end

    puts '-' * divider_size

    b.report('RABL Simple: Collection') do
      sample_size.times do
        Rabl.render(event_collection, 'events/index', view_path: rabl_view_path, format: :json)
      end
    end

    b.report('AMS Simple: Collection') do
      sample_size.times do
        ActiveModel::ArraySerializer.new(event_collection, each_serializer: EventSummarySerializer).to_json
      end
    end

    b.report('Presenters Simple: Collection') do
      sample_size.times do
        event_collection.map { |event| EventSummaryPresenter.new(event).as_json }.to_json
      end
    end

    puts '-' * divider_size

    b.report('RABL Complex: Collection') do
      sample_size.times do
        Rabl.render(event_collection, 'basketball/events/index', view_path: rabl_view_path, format: :json)
      end
    end

    b.report('AMS Complex: Collection') do
      sample_size.times do
        ActiveModel::ArraySerializer.new(event_collection, each_serializer: Basketball::EventSerializer).to_json
      end
    end

    b.report('Presenters Complex: Collection') do
      sample_size.times do
        event_collection.map { |event| Basketball::EventPresenter.new(event).as_json }.to_json
      end
    end
  end
end
