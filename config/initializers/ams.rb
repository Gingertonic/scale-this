ActiveModelSerializers.config.tap do |c|
  c.adapter = :json_api
  c.jsonapi_include_toplevel_object = true
  c.jsonpi_version = '1.0'
  c.key_transform = :unaltered
end
