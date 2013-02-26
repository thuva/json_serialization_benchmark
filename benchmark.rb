$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))

require 'benchmark'
require 'json_serialization_benchmark'

Benchmark.benchmark(Benchmark::CAPTION, 25) do |b|
  sample_size = 50

  event = EventFactory.build_event
  rabl_view_path = File.expand_path(File.dirname(__FILE__) + '/lib/rabl/views')

  b.report('RABL') do
    sample_size.times do
      Rabl.render(event, 'events/show', view_path: rabl_view_path, format: :json)
    end
  end

  b.report('ActiveModel Serializer') do
    sample_size.times do
      EventSerializer.new(event, root: false).to_json
    end
  end
end
