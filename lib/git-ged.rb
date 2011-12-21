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
autoload :HelpCmd, 'git-ged/help_cmd'
autoload :InitCmd, 'git-ged/init_cmd'
autoload :CloneCmd, 'git-ged/clone_cmd'
autoload :AttachCmd, 'git-ged/attach_cmd'
autoload :FetchCmd, 'git-ged/fetch_cmd'
autoload :PushCmd, 'git-ged/push_cmd'

# over-and-above-git commands
autoload :WorkspaceCmd, 'git-ged/workspace_cmd'
autoload :CommitCmd, 'git-ged/commit_cmd'

# high-level git-ged mutators
autoload :IngestCmd, 'git-ged/ingest_cmd'
autoload :ImportCmd, 'git-ged/import_cmd'

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
