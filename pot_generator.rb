require 'puppet-pot-generator'
require 'pry'

path = File.expand_path(ARGV[0])

def do_shit(file)
  parser = Puppet::Pops::Parser::EvaluatingParser.new
  jim = PuppetPotGenerator::PotGenerator.new
  program = parser.parse_file(file)
  jim.compute(program)
end

if File.directory?(path)
  Dir["#{path}/**/*.pp"].each do |f|
    do_shit(f)
  end
else
  do_shit(path)
end
