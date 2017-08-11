require 'puppet_pot_generator'

desc 'Generate POT file for puppet code'
task :generate_puppet_pot do
  result = PuppetPotGenerator.generate_puppet_pot_file
  if result
  # puts "POT metadata file #{PuppetPotGenerator.puppet_pot_file_path} has been generated"
  else
    exit 1
  end
end
