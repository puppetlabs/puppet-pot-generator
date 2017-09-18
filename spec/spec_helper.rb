require 'puppet_pot_generator'
require 'puppet'
require 'puppet/pops/parser/evaluating_parser'

LOCALES_DIR = File.join(File.dirname(__FILE__), '../locales')

def create_dirs(dirs)
  puts "Creating directories: #{dirs}"
  dirs.each { |dir| FileUtils.mkdir_p(dir) }
end

def destroy_dirs(dirs)
  puts "Destroying directories: #{dirs}"
  dirs.each { |dir| FileUtils.rm_rf(dir) if File.exist? dir }
end

RSpec.configure do |c|
  c.before(:all) do # rubocop:disable RSpec/BeforeAfterAll
    create_dirs([LOCALES_DIR])
  end

  c.after(:all) do # rubocop:disable RSpec/BeforeAfterAll
    destroy_dirs([LOCALES_DIR])
  end
end
