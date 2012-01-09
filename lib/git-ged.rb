$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed

# core
require 'fileutils'
require 'time'

# stdlib
require 'logger'
require 'digest/sha1'

# third party
require 'grit'

# internal requires

# common libraries
require 'git-ged/repo'

# git-like repo interaction
require 'git-ged/cli'
require 'git-ged/init'

# internal support classes

module GitGed
  VERSION = '0.0.2'

  class << self

    def version
      VERSION
    end

    attr_accessor :debug

    def debug= onoff
      Grit.debug = onoff
      @debug = onoff
      @logger.level = onoff ? ::Logger::DEBUG : ::Logger::INFO
    end

    # The standard +logger+ for debugging git-ged calls - this defaults to a plain STDOUT logger
    attr_accessor :logger

    def log(str, &block)
      if block_given?
        logger.debug &block
      else
        logger.debug str
      end
    end

    def message(str)
      logger.info str
    end

    private

    def new_logger
      logger = ::Logger.new STDOUT
      default_formatter = ::Logger::Formatter.new
      logger.formatter = lambda do |severity, datetime, progname, msg|
        if severity == "DEBUG"
          default_formatter.call(severity, datetime, progname, msg)
        else
          msg
        end
      end
      logger
    end
  end

  @logger ||= new_logger

  # turn debug logging off by default
  self.debug = false

end
