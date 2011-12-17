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

# repo interation
require 'git-ged/init'
require 'git-ged/clone'
require 'git-ged/attach'
require 'git-ged/fetch'
require 'git-ged/push'

# common over-and-above-git commands
require 'git-ged/workspace'
require 'git-ged/commit'

# high-level mutators
require 'git-ged/ingest'
require 'git-ged/import'

# internal support classes

module GitGed
  VERSION = '0.0.1'

  class << self
    # Set +debug+ to true to log all git calls and responses
    attr_accessor :debug
    attr_accessor :grit_debug

    def version
      VERSION
    end

    def grit_debug= onoff
      Grit.debug = onoff
    end

    # The standard +logger+ for debugging grit calls - this defaults to a plain STDOUT logger
    attr_accessor :logger

    def log(str)
      logger.debug { str }
    end
  end

  self.debug = false
  self.grit_debug = false

  @logger ||= ::Logger.new(STDOUT)

end
