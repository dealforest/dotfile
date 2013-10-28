begin
  require 'awesome_print'
  require 'tapp'
rescue LoadError
  puts 'failed to require.. :('
end

Pry.config.prompt = [
  proc {|target_self, nest_level, pry|
    nested = (nest_level.zero?) ? '' : ":#{nest_level}" 
    "[#{pry.input_array.size}] #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}(#{Pry.view_clip(target_self)})#{nested}> "
  },
  proc {|target_self, nest_level, pry|
    nested = (nest_level.zero?) ?  '' : ":#{nest_level}"
    "[#{pry.input_array.size}] #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}(#{Pry.view_clip(target_self)})#{nested}* "
  }
]

# refs: https://github.com/nixme/pry-debugger#tips
if defined?(PryDebugger)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'h', 'help'
end

# refs: https://github.com/pry/pry/wiki/FAQ#wiki-awesome_print
if defined? AwesomePrint
  begin
    require 'awesome_print'
    Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }
    # Pry.config.print = proc { |output, value| output.puts value.ai } #ページングなし
  rescue LoadError => err
    puts "no awesome_print :("
    puts err
  end
end

# http://hiroki.jp/2013/02/27/6766/
begin
  require 'hirb'
rescue LoadError
  # Missing goodies, bummer
end

if defined? Hirb
  # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |output, value|
        Hirb::View.view_or_page_output(value) || @old_print.call(output, value)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end

# https://gist.github.com/txus/5822580
def write_backtrace name, backtrace, filename
  exceptions = Regexp.union([
    /\.bundle/,
    /spec/,
    /test/,
    /lib\/ruby\/1.9.1/
  ])

  backtrace.reject! { |line| line =~ exceptions }

  File.open(filename, 'a') do |f|
    f.write "* #{name}\n\n" + backtrace.join("\n") + "\n\n"
  end
end

# Example usage:
#
#   trace Redis::Client#process my_redis_calls.log
#
Pry.commands.block_command(/trace ([^ ]+) ([^ ]+)$/, "Trace a method invocation and log it to a file", :listing => "trace") do |bp, filename|
  run "breakpoint #{bp} if (write_backtrace(%{#{bp}}, caller, %{#{filename}}); false)"
  run "continue"
end
