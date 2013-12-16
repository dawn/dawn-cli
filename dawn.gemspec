#
# dawn/dawn.gemspec
#
Gem::Specification.new do |s|
  s.name        = "dawn"
  s.homepage    = 'http://anzejagodic.com:5000/'
  s.version     = "0.0.0"
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Dawn main gem"
  s.date        = Time.now.to_date.to_s

  s.authors = ["Blaž Hrastnik", "Corey Powell"]

  s.add_runtime_dependency "dawn-api"
  s.add_runtime_dependency "dawn-cli"
end