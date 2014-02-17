require 'mypeople'

config = YAML.load_file(Rails.root.join("config/mypeople.yml"))[Rails.env]
key = config['key']
host = config['host']

Mypeople.configure do |config|
  config.key = key
  config.host = host
end
