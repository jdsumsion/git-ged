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

# git-like repo interation
require 'git-ged/help_cmd'
require 'git-ged/init_cmd'
require 'git-ged/clone_cmd'
require 'git-ged/attach_cmd'
require 'git-ged/fetch_cmd'
require 'git-ged/push_cmd'

# over-and-above-git commands
require 'git-ged/workspace_cmd'
require 'git-ged/commit_cmd'

# high-level git-ged mutators
require 'git-ged/ingest_cmd'
require 'git-ged/import_cmd'

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
