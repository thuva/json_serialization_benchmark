$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))

require 'bixby/bench'
require 'json_serialization_benchmark'

require 'serializers/event_summary_serializer'
require 'serializers/team_serializer'
require 'serializers/basketball/event_serializer'
require 'active_model/serializer/version'

require 'presenters/event_summary_presenter'
require 'presenters/team_presenter'
require 'presenters/basketball/event_presenter'

require 'multi_json'
require 'oj'
Oj.mimic_JSON() # Use OJ for benchmarks using #to_json
MultiJson.use(:oj) # Use OJ by default from multi_json

module SerializationBenchmark

  collection_size = 100
  rabl_view_path  = File.expand_path(File.dirname(__FILE__) + '/lib/rabl/views')

  event = EventFactory.build_event
  team  = event.home_team

  event_collection = collection_size.times.map { event }
  team_collection  = collection_size.times.map { team }

  Bixby::Bench.run(10_000) do |b|

    puts "\n\nUsing Ruby version: #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"

    # MEMBER TESTS
    puts "\n\nMember tests:\n\n"

    # ULTRA SIMPLE
    b.sample("RABL #{Rabl::VERSION} Ultra Simple: Member") do
      Rabl.render(team, 'teams/item', view_path: rabl_view_path, format: :json)
    end

    b.sample("AMS #{ActiveModel::Serializer::VERSION} Ultra Simple: Member") do
      JsonEncoder.dump(TeamSerializer.new(team).to_json)
    end

    b.sample("Presenters Ultra Simple: Member") do
      JsonEncoder.dump(TeamPresenter.new(team).to_json)
    end

    b.sample("ApiView Ultra Simple: Member") do
      ApiView::Engine.render(team, nil, :format => "json")
    end

    b.sample("Jbuilder #{Gem.loaded_specs['jbuilder'].version.to_s} Ultra Simple: Member") do
      Jbuilder.render('teams/show', locals: { team: team }, layout: false, format: :json)
    end


    # SIMPLE
    b.divider

    b.report("RABL #{Rabl::VERSION} Simple: Member") do
      Rabl.render(event, 'events/item', view_path: rabl_view_path, format: :json)
    end

    b.report("AMS #{ActiveModel::Serializer::VERSION} Simple: Member") do
      JsonEncoder.dump(EventSummarySerializer.new(event).to_json)
    end

    b.report("Presenters Simple: Member") do
      JsonEncoder.dump(EventSummaryPresenter.new(event).to_json)
    end

    b.report("ApiView Simple: Member") do
      ApiView::Engine.render(event, nil, :format => "json", :use => EventSummaryApiView)
    end

    b.sample("Jbuilder #{Gem.loaded_specs['jbuilder'].version.to_s} Simple: Member") do
      Jbuilder.render('events/show', locals: { event: event }, layout: false, format: :json)
    end


    # COMPLEX
    b.divider

    b.report("RABL #{Rabl::VERSION} Complex: Member") do
      Rabl.render(event, 'basketball/events/show', view_path: rabl_view_path, format: :json)
    end

    b.report("AMS #{ActiveModel::Serializer::VERSION} Complex: Member") do
      JsonEncoder.dump(Basketball::EventSerializer.new(event).to_json)
    end

    b.report("Presenters Complex: Member") do
      JsonEncoder.dump(Basketball::EventPresenter.new(event).to_json)
    end

    b.report("ApiView Complex: Member") do
      ApiView::Engine.render(event, nil, :format => "json", :use => BasketballEventApiView)
    end

    b.sample("Jbuilder #{Gem.loaded_specs['jbuilder'].version.to_s} Complex: Member") do
      Jbuilder.render('basketball/events/show', locals: { event: event }, layout: false, format: :json)
    end
  end


  # COLLECTION TESTS
  puts "\n\nCollection tests:\n\n"

  Bixby::Bench.run(100) do |b|

    # ULTRA SIMPLE
    b.report("RABL #{Rabl::VERSION} Ultra Simple: Collection") do
      Rabl.render(team_collection, 'teams/index', view_path: rabl_view_path, format: :json)
    end

    b.report("AMS #{ActiveModel::Serializer::VERSION} Ultra Simple: Collection") do
      result = ActiveModel::ArraySerializer.
        new(team_collection, each_serializer: TeamSerializer).
        as_json

      JsonEncoder.dump(result)
    end

    b.report("Presenters Ultra Simple: Collection") do
      result = team_collection.map { |team| TeamPresenter.new(team).as_json }
      JsonEncoder.dump(result)
    end

    b.report("ApiView Ultra Simple: Collection") do
      ApiView::Engine.render(team_collection, nil, :format => "json")
    end

    b.report("Jbuilder #{Gem.loaded_specs['jbuilder'].version.to_s} Ultra Simple: Collection") do
      Jbuilder.render('teams/index', locals: { teams: team_collection }, layout: false, format: :json)
    end


    # SIMPLE
    b.divider

    b.report("RABL #{Rabl::VERSION} Simple: Collection") do
      Rabl.render(event_collection, 'events/index', view_path: rabl_view_path, format: :json)
    end

    b.report("AMS #{ActiveModel::Serializer::VERSION} Simple: Collection") do
      result = ActiveModel::ArraySerializer.
        new(event_collection, each_serializer: EventSummarySerializer).
        as_json

      JsonEncoder.dump(result)
    end

    b.report("Presenters Simple: Collection") do
      result = event_collection.map { |event| EventSummaryPresenter.new(event).as_json }
      JsonEncoder.dump(result)
    end

    b.report("ApiView Simple: Collection") do
      ApiView::Engine.render(event_collection, nil, :format => "json", :use => EventSummaryApiView)
    end

    b.report("Jbuilder #{Gem.loaded_specs['jbuilder'].version.to_s} Ultra Simple: Collection") do
      Jbuilder.render('events/index', locals: { events: event_collection }, layout: false, format: :json)
    end


    # COMPLEX
    b.divider

    b.report("RABL #{Rabl::VERSION} Complex: Collection") do
      Rabl.render(event_collection, 'basketball/events/index', view_path: rabl_view_path, format: :json)
    end

    b.report("AMS #{ActiveModel::Serializer::VERSION} Complex: Collection") do
      result = ActiveModel::ArraySerializer.
        new(event_collection, each_serializer: Basketball::EventSerializer).
        as_json

      JsonEncoder.dump(result)
    end

    b.report("Presenters Complex: Collection") do
      result = event_collection.map { |event| Basketball::EventPresenter.new(event).as_json }
      JsonEncoder.dump(result)
    end

    b.report("ApiView Complex: Collection") do
      ApiView::Engine.render(event_collection, nil, :format => "json", :use => BasketballEventApiView)
    end

    b.report("Jbuilder #{Gem.loaded_specs['jbuilder'].version.to_s} Ultra Simple: Collection") do
      Jbuilder.render('basketball/events/index', locals: { events: event_collection }, layout: false, format: :json)
    end

  end

end
