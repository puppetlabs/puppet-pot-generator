# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puppet-pot-generator/version'

Gem::Specification.new do |spec|
  spec.name = 'puppet-pot-generator'
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
  spec.description = <<-EOF
    Generates a pot file from your puppet code
  EOF
  spec.summary = 'Generates a pot file from your puppet code'
  spec.add_runtime_dependency 'puppet', '~> 5.0'
  spec.add_runtime_dependency 'semantic_puppet'
end
