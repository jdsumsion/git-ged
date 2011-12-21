module GitGed

  class CmdSupport

    def name
      self.class.name.sub(/.*::([^:]+)Cmd/, '\1').downcase!
    end

  end

end
