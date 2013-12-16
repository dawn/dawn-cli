#
# dawn/dawn-cli.gemspec
#
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'dawn/cli/version'

Gem::Specification.new do |s|
  s.name        = "dawn-cli"
  s.homepage    = 'http://anzejagodic.com:5000/'
  s.version     = Dawn::CLI::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Dawn CLI"
  s.date        = Time.now.to_date.to_s

  s.authors = ["Blaž Hrastnik", "Corey Powell"]

  s.add_runtime_dependency "dawn-api"

  s.executables = "dawn"
  s.require_path = "lib"
  s.files = ["lib/dawn/cli.rb"] +
            Dir.glob("lib/dawn/cli/**/*") +
            Dir.glob("bin/**/*")
end