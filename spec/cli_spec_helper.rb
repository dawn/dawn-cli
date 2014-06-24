$:.unshift(File.expand_path("../lib", File.dirname(__FILE__)))
require "rspec"
require "rspec/expectations"
require "dawn/cli/parser"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.color = true
  config.formatter = :documentation
  config.tty = true
end
