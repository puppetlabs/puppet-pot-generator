require 'spec_helper'

describe 'puppet_pot_generator' do
  let(:file) { PuppetPotGenerator::PUPPET_POT_FILE }
  let(:content) { File.read(file) }

  it 'testing complete' do
    expect(true).to be true # rubocop:disable RSpec/ExpectActual
  end

  describe '#generate_puppet_pot_file' do
    it 'is expected to not raise an error' do
      expect { PuppetPotGenerator.generate_puppet_pot_file }.not_to raise_error
    end

    it 'is expected to append to the puppet POT file' do
      expect(File.exist?(file)).to be true
    end

    it 'is expected to create a POT header' do
      expect(content).to match %r{POT-Creation-Date}
    end
  end

  describe '#report_on_translate_function' do
    let(:parser) { Puppet::Pops::Parser::EvaluatingParser.new }

    before :each do
      File.open('puppet.pp', 'w') { |file| file.write "translate('Hello, world!')" }
      statement = parser.parse_file('puppet.pp').body
      PuppetPotGenerator.new.report_on_translate_function(statement)
    end

    after :each do
      FileUtils.rm('puppet.pp')
    end

    it 'is expected to write file location to the puppet POT file' do
      expect(content).to match %r{puppet.pp}
    end

    it 'is expected to write msgid to the puppet POT file' do
      expect(content).to match %r{msgid "Hello, world!"}
    end
  end
end
