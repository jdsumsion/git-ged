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
autoload :InitCmd, 'git-ged/init'
#autoload :CloneCmd, 'git-ged/clone_cmd'
#autoload :AttachCmd, 'git-ged/attach_cmd'
#autoload :FetchCmd, 'git-ged/fetch_cmd'
#autoload :PushCmd, 'git-ged/push_cmd'

# over-and-above-git commands
#autoload :WorkspaceCmd, 'git-ged/workspace_cmd'
#autoload :CommitCmd, 'git-ged/commit_cmd'

# high-level git-ged mutators
#autoload :IngestCmd, 'git-ged/ingest_cmd'
#autoload :ImportCmd, 'git-ged/import_cmd'

# internal support classes

module GitGed
  VERSION = '0.0.1'

  class << self

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

  @logger ||= ::Logger.new(STDOUT)

end
