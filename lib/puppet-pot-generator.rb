#sfijsdf
require 'pry'
require 'puppet'
module PuppetPotGenerator
  class PotGenerator
    attr_reader :metrics

    def initialize()
      @@potgenerator_visitor ||= Puppet::Pops::Visitor.new(nil, "potgenerator", 0, 0)
    end

    def compute(target)
      @path = []
      target._pcore_all_contents(@path) { |element| potgenerator(element) }
    end

    def statementStuff(statement)
      if statement.functor_expr.class == Puppet::Pops::Model::QualifiedName && statement.functor_expr.value == "tstr"
        lineNumber = statement.arguments[0].locator.line_for_offset(statement.arguments[0].offset)
        pathToFile = statement.arguments[0].file
        if defined?(statement.arguments[0].segments)
          stringTobeTranslated = statement.arguments[0].segments[0].value
        else
          stringTobeTranslated = statement.arguments[0].value
        end
        print "#. " + pathToFile + ":" + lineNumber.to_s + "\n"
        print 'msgid: "' + stringTobeTranslated + "\"\n"
        print "msgstr: \"\"\n"
      end
    end

    def potgenerator(o)
      @@potgenerator_visitor.visit_this_0(self, o)
    end

    def potgenerator_Object(o)
    end

    def potgenerator_CallExpression(o)
      statementStuff(o)
    end
  end
end
