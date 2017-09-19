require 'puppet'

# Parses and reports every instance of a translate function
class PuppetPotGenerator
  attr_reader :metrics
  TRANSLATE_FUNCTION = 'translate'.freeze
  PATH_TO_MANIFESTS = './manifests/**/*.pp'.freeze
  PATH_TO_LOCALES = './locales'.freeze
  PUPPET_POT_FILE = File.join(PATH_TO_LOCALES, 'puppet.pot')

  def self.generate_puppet_pot_file
    raise "PuppetPotGenerator: #{PATH_TO_LOCALES} folder does not exist" unless File.directory?(PATH_TO_LOCALES)
    raise 'PuppetPotGenerator: requires version 5 of greater of puppet' unless Puppet::Util::Package.versioncmp(Puppet.version, '5.0.0') >= 0
    parser = Puppet::Pops::Parser::EvaluatingParser.new
    ppg = PuppetPotGenerator.new
    open(PUPPET_POT_FILE, 'w') { |file| file << ppg.header }
    Dir[PATH_TO_MANIFESTS].each do |file|
      program = parser.parse_file(file)
      ppg.compute(program)
    end
  end

  def initialize
    @potgenerator_visitor ||= Puppet::Pops::Visitor.new(nil, 'potgenerator', 0, 0)
  end

  def compute(target)
    @path = []
    target._pcore_all_contents(@path) { |element| potgenerator(element) }
  end

  def header
    <<-HEADER
  #, fuzzy
  msgid ""
  msgstr ""
  "Project-Id-Version: PACKAGE VERSION\\n"
  "Report-Msgid-Bugs-To: \\n"
  "POT-Creation-Date: #{Time.now}\\n"
  "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\\n"
  "Last-Translator: FULL NAME <EMAIL@ADDRESS>\\n"
  "Language-Team: LANGUAGE <LL@li.org>\\n"
  "MIME-Version: 1.0\\n"
  "Content-Type: text/plain; charset=UTF-8\\n"
  "Content-Transfer-Encoding: 8bit\\n"
  "X-Generator: Translate Toolkit 2.0.0\\n"

  HEADER
  end

  def report_on_translate_function(statement)
    return unless statement.functor_expr.class == Puppet::Pops::Model::QualifiedName && statement.functor_expr.value == TRANSLATE_FUNCTION
    line_number = statement.arguments[0].locator.line_for_offset(statement.arguments[0].offset)
    path_to_file = statement.arguments[0].file
    string_to_be_translated = if defined?(statement.arguments[0].segments)
                                statement.arguments[0].segments[0].value
                              else
                                statement.arguments[0].value
                              end
    pot_entry =  '#. ' + path_to_file + ':' + line_number.to_s + "\n"
    pot_entry << 'msgid "' + string_to_be_translated + "\"\n"
    pot_entry << "msgstr \"\"\n"
    open(PUPPET_POT_FILE, 'a') do |file|
      file << pot_entry
    end
  end

  def potgenerator(o)
    @potgenerator_visitor.visit_this_0(self, o)
  end

  def potgenerator_Object(o); end # rubocop:disable Style/MethodName

  def potgenerator_CallExpression(o) # rubocop:disable Style/MethodName
    report_on_translate_function(o)
  end
end
