require 'api_view/api_view'
# load api_view models
Find.find(File.expand_path(File.dirname(__FILE__) + '/views')) do |path|
  next if not File.file? path
  require path
end