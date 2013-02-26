require File.join(File.dirname(__FILE__), '..', 'config', 'environment')

require 'active_support/core_ext/object/to_json'

require 'models/model'
require 'models/box_score'
require 'models/event'
require 'models/event_factory'
require 'models/play_by_play_record'
require 'models/team'

require 'serializers/init'
require 'serializers/event_serializer'

require 'rabl/init'
