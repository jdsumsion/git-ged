module GitGed
  class Repo

    # Initializes a new git-ged repo
    def init(args, options={})
      system "git init -q #{args.map{|s| "\"#{s}\"" }.join(" ")}"
      GitGed.log "Created empty git-ged repo"
    end

  end
end
