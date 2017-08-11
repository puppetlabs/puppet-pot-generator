require 'puppet_pot_generator'

desc 'Generate POT file for puppet code'
task :generate_puppet_pot do
  result = PuppetPotGenerator.generate_metadata_pot
  if result
    puts "POT metadata file #{PuppetPotGenerator.metadata_path} has been generated"
  else
    exit 1
  end
end
