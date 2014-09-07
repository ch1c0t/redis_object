lib = File.expand_path './lib/'
$:.unshift lib unless $:.include? lib

Gem::Specification.new do |g|
  g.name    = 'redis_object'
  g.version = '0.0.0'
  g.summary = 'Some persistence for Ruby objects provided by Redis.'
  g.authors = ['Anatoly Chernow']

  g.require_path = 'lib'
  g.add_dependency 'redis'
  g.add_development_dependency 'rspec'
end
