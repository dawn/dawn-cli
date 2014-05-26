#
# dawn/dawn-api.gemspec
#
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'dawn/api/version'

Gem::Specification.new do |s|
  s.name        = 'dawn-api'
  s.summary     = 'Dawn API'
  s.description = 'Dawn Client API'
  s.homepage    = 'http://anzejagodic.com:5000/'
  s.version     = Dawn::Api::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = Time.now.to_date.to_s
  s.license     = 'MIT'
  s.authors     = ['Blaž Hrastnik', 'Corey Powell']

  s.add_runtime_dependency 'commander', '~> 4.2'
  s.add_runtime_dependency 'excon',     '~> 0.33'
  s.add_runtime_dependency 'json',      '~> 1.8'
  s.add_runtime_dependency 'netrc',     '~> 0.7'
  s.add_runtime_dependency 'sshkey',    '~> 1.6'

  s.require_path = 'lib'
  s.files = ['lib/dawn/api.rb'] +
            Dir.glob('lib/dawn/api/**/*')
end