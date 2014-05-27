Rabl.configure do |config|
  config.json_engine = JsonEncoder
  config.cache_sources = true
  config.include_json_root = false
  config.enable_json_callbacks = true
end
