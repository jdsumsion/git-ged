#!/usr/bin/env ruby

require 'git-ged'

module GitGed
  class CLI

#    include Subcommands
#
#    # patch until subcommand 1.0.7 comes out
#    attr_accessor :appname
#    def print_actions
#      super.sub(/See '.* help COMMAND'/, "See '#{appname} help COMMAND'")
#    end

#    def initialize
#      @options = {}
#
#      self.appname = "git ged"
#      global_options do |opts|
#        opts.banner = "Usage: #{appname} [options] [subcommand [options]]"
#        opts.separator ""
#        opts.separator "Global options are:"
#        opts.on("-v", "--[no-]verbose", "Show git-ged & grit debug") do |v|
#          GitGed.debug = v
#        end
#      end
#      add_help_option
#
#      command :init do |opts|
#        opts.banner = "Usage: #{appname} init -m msg [repo]"
#        opts.description = "Initializes a new git-ged repo"
#        opts.separator ""
#        opts.separator "Options:"
#        opts.on "-m INTENT", "--message INTENT" do |intent|
#          @options[:intent] = intent
#        end
#      end
#    end

    def run
#      cmd = opt_parse()
#      if cmd
#        Repo.new.send cmd, ARGV, @options
#      else
#        puts global_options { |opts| opts }
#      end
    end

  end
end
