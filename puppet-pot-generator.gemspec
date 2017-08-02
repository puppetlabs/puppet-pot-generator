Gem::Specification.new do |s|
  s.name = 'puppet-pot-generator'
  s.version = '0.0.1'
  s.summary = 'Generate a pot file from your puppet code'
  s.authors = ['Puppet']
  s.add_runtime_dependency 'puppet', '~> 5.0'
  s.add_runtime_dependency 'pry'
end
