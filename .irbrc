# unless RUBY_VERSION.match?(/^3\.1\.\d/)
#   require 'irb/completion'
#   require 'wirb'
#   Wirb.start
# end

IRB.conf[:PROMPT][:DEFAULT] = {
  :PROMPT_I => "%N(%m):%03n:%i> ",
  :PROMPT_N => "%N(%m):%03n:%i> ",
  :PROMPT_S => "%N(%m):%03n:%i%l ",
  :PROMPT_C => "%N(%m):%03n:%i* ",
  :RETURN => "=> %s\n"
}

class Object
  def my_methods_only
    my_super = self.class.superclass
    my_super ? methods - my_super.instance_methods : methods
  end

  def my_methods_only_no_mixins
    self.class.ancestors.inject(methods) do |mlist, ancestor|
      mlist = mlist - ancestor.instance_methods unless ancestor.is_a? Class
      mlist
    end
  end
end

module Kernel
  def levenshtein_distance(s, t)
    t.chars.map.with_index.inject(0..s.size) do |r, (a, z)|
      z += 1
      [z] + s.chars.zip(r.each_cons(2)).map do |b, (x, y)|
        z = [y + 1, z + 1, x + (a == b ? 0 : 1)].min
      end
    end.last
  end
end

# module SourceLocation
#   module Inspection
#     def pretty_print(printer = nil)
#       printer.text join(':')
#     end
#   end

#   def source_location
#     super.tap do |orig|
#       if orig.singleton_class
#         orig.singleton_class.prepend Inspection
#       end
#     end
#   end
# end

# UnboundMethod.prepend SourceLocation
# Method.prepend SourceLocation
