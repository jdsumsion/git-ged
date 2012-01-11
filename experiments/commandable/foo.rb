require 'commandable'
require 'optparse'

class Foo
  extend Commandable

  # :default is optional, and can only be on one method
  command "hello", :default
  def hello(world="world")  # the default value is expressed inline in real ruby
    puts "hello #{world.inspect}"
    raise_on_invalid_world world
  end

  def raise_on_invalid_world(world)
    raise FriendlyError, world if world =~ /^nowhere/
    raise RuntimeError, world if world =~ /^never/
  end

  # lets me do full commandline parsing in the place the option will be used
  command "hello2", :rest
  def hello2(*args)
    opts = OptionParser.new
    options = { world: "world" }
    opts.on "-w WORLD", "--world WORLD" do |world|
      options[:world] = world
    end
    opts.order! args

    puts "hello2 #{options[:world].inspect}, args: #{args.inspect}"

    raise_on_invalid_world options[:world]
  end
end

class FriendlyError < RuntimeError
  def friendly_name
    "bogus place, #{message}"
  end
end

Commandable.color_output = false
Commandable.single_command_only = true
Commandable.execute ARGV, :silent
