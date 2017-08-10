require_relative '../puppet-pot-generator/puppet_pot_generator'

namespace :puppet_pot_generator do
  desc 'Generate POT file for puppet code'
  task :generate_pot do
    begin
      result = PuppetPotGenerator::PotGenerator.generate_metadata_pot
      if result
        puts "POT metadata file #{PuppetPotGenerator::PotGenerator.metadata_path} has been generated"
      else
        exit 1
      end
    rescue GettextSetup::NoConfigFoundError => e
      puts e.message
    end
  end
end
