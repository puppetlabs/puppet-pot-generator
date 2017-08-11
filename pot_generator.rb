require 'puppet_pot_generator'

path = File.expand_path(ARGV[0])

def process_file(file)
  parser = Puppet::Pops::Parser::EvaluatingParser.new
  ppg = PuppetPotGenerator.new
  program = parser.parse_file(file)
  ppg.compute(program)
end

if File.directory?(path)
  Dir["#{path}/**/*.pp"].each do |file|
    process_file(file)
  end
else
  process_file(path)
end
