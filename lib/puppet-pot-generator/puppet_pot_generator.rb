require 'puppet'

# parses a file and reports every instance of a translate function
class PotGenerator
  attr_reader :metrics
  TRANSLATE_FUNCTION = 'translate'.freeze

  def initialize
    @potgenerator_visitor ||= Puppet::Pops::Visitor.new(nil, 'potgenerator', 0, 0)
  end

  def compute(target)
    @path = []
    target._pcore_all_contents(@path) { |element| potgenerator(element) }
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
    print '#. ' + path_to_file + ':' + line_number.to_s + "\n"
    print 'msgid: "' + string_to_be_translated + "\"\n"
    print "msgstr: \"\"\n"
  end

  def potgenerator(o)
    @potgenerator_visitor.visit_this_0(self, o)
  end

  def potgenerator_Object(o); end # rubocop:disable Style/MethodName

  def potgenerator_CallExpression(o) # rubocop:disable Style/MethodName
    report_on_translate_function(o)
  end
end
