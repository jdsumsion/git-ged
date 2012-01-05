#!/usr/bin/env ruby

require 'git-ged'
require 'optparse'
require 'subcommand'

module GitGed
  class CLI

    include Subcommands

    def initialize
      @options = {}
      appname = File.basename($0)

      global_options do |opts|
        opts.banner = "Usage: #{appname} [options] [subcommand [options]]"
        opts.separator ""
        opts.separator "Global options are:"
        opts.on("-v", "--[no-]verbose", "Show git-ged & grit debug") do |v|
          GitGed.debug = v
          GitGed.grit_debug = v
        end
      end
      add_help_option

      command :init do |opts|
        opts.banner = "Usage: #{appname} init [-m msg] [repo]"
        opts.description = "Initializes a new git-ged repo"
        opts.separator ""
        opts.on "-m MESSAGE", "--message MESSAGE" do |msg|
          @options[:message] = msg
        end
      end
    end

    def run
      cmd = opt_parse()
      Repo.new.send cmd, ARGV, @options
    end

  end
end
