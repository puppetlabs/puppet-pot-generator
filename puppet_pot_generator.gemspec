lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puppet_pot_generator/version'

Gem::Specification.new do |spec|
  spec.name = 'puppet_pot_generator'
  spec.version     = PuppetPotGenerator::VERSION
  spec.homepage    = 'https://github.com/puppetlabs/puppet-pot-generator'
  spec.license     = 'Apache 2.0'
  spec.authors     = ['Puppet, Inc.']
  spec.email       = ['info@puppet.com']
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.description = <<-DESC
    Generates a pot file from your puppet code
  DESC
  spec.summary = 'Generates a pot file from your puppet code'

  spec.add_runtime_dependency 'puppet'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rubocop', '< 0.53'
  spec.add_development_dependency 'rubocop-rspec'
end
