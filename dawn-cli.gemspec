#
# dawn-cli.gemspec
#
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'dawn/cli/version'

Gem::Specification.new do |s|
  s.name        = 'dawn-cli'
  s.summary     = 'Dawn CLI'
  s.description = 'CLI for Dawn PaaS'
  s.homepage    = 'https://github.com/dawn/dawn-cli'
  s.version     = Dawn::CLI::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.date        = Time.now.to_date.to_s
  s.license     = 'MIT'
  s.authors     = ['Blaž Hrastnik', 'Corey Powell']

  s.add_runtime_dependency 'commander',      '~> 4.2'
  s.add_runtime_dependency 'time-lord',      '~> 1.0'
  s.add_runtime_dependency 'terminal-table', '~> 1.4'
  s.add_runtime_dependency 'dawn-api',       '~> 0.9'

  s.executables = 'dawn'
  s.require_path = 'lib'
  s.files = ['lib/dawn/cli.rb'] +
            Dir.glob('lib/dawn/cli/**/*') +
            Dir.glob('bin/**/*')
end
