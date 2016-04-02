require File.join(File.dirname(__FILE__), '..', 'config', 'environment')

require 'active_support/json/encoding'

require 'json_encoder'

require 'models/model'
require 'models/box_score'
require 'models/event'
require 'models/event_factory'
require 'models/play_by_play_record'
require 'models/team'

require 'rabl/init'
require 'serializers/init'
require 'api_view/init'
require 'jbuilder/init'
