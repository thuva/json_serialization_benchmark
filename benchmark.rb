$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))

require 'benchmark'
require 'json_serialization_benchmark'
require 'serializers/basketball/event_serializer'

Benchmark.benchmark(Benchmark::CAPTION, 25) do |b|
  sample_size = 50

  event = EventFactory.build_event
  rabl_view_path = File.expand_path(File.dirname(__FILE__) + '/lib/rabl/views')

  b.report('RABL') do
    sample_size.times do
      Rabl.render(event, 'basketball/events/show', view_path: rabl_view_path, format: :json)
    end
  end

  b.report('ActiveModel Serializer') do
    sample_size.times do
      Basketball::EventSerializer.new(event).to_json
    end
  end
end
