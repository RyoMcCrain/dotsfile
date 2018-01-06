# awesome_print
begin
  require "awesome_print"
  Pry.config.print = proc { |output, value| output.puts value.ai }
rescue LoadError
  puts "no gem install awesome_print "
end

# hirb
begin
  require "hirb"
rescue LoadError
  require "no gem install hirb "
end

if defined? Hirb
  # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |*args|
        Hirb::View.view_or_page_output(args[1]) || @old_print.call(*args)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end

Pry.config.editor = "nvim"
Pry.config.prompt = proc do |obj, nest_level, _pry_|
version = ''
version << "#{RUBY_VERSION}"

"#{version} #{Pry.config.prompt_name}(#{Pry.view_clip(obj)})> "
end
