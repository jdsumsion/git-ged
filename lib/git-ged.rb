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

    def grit_debug= onoff
      Grit.debug = onoff
    end

    # The standard +logger+ for debugging git-ged calls - this defaults to a plain STDOUT logger
    attr_accessor :logger

    def log(str)
      logger.debug { str }
    end
  end

  self.debug = false
  self.grit_debug = false

  @logger ||= ::Logger.new(STDOUT)

end
