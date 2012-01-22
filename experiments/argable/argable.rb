require 'forwardable'

module Argable

  def initialize_options options_spec
    @arg_parser = ArgParser.new options_spec
  end

  extend Forwardable
  def_delegator :@arg_parser, :parse_initial_options
  def_delegator :@arg_parser, :parse

  class ArgParser

    OPTION_PATTERN = /^--?(.+)/

    attr_reader :defaults

    # Initializes the +options+ hash by merging an entry for each option like
    # +{ :verbose[_v] => false }+ or +{ :verbose[_v] => [ nil, lambda ] }+ or
    # +{ :verbose[_v] => [ default, :required_value, :required_option, lambda ] }+
    # with extra entries keyed under the short option name (like :v for
    # :verbose).
    def initialize options_spec
      opts = {}
      short_opts = {}
      options_spec.each_entry do |key, *values|
        if key =~ /^([^_]+)_(.)$/ then
          opts[$1.to_sym] =
          short_opts[$2.to_sym] = Option.new *[ $1, values ].flatten
        else
          opts[key.to_sym] = Option.new *[ key.to_s, values ].flatten
        end
      end
      @options = opts
      @defaults = calculate_defaults

      # merge the short opts in after calculating defaults to avoid duplicate
      # entries in the defaults hash (known by long AND short keys)
      @options_with_short_keys = @options.merge short_opts
    end

    # Parses +argv+ up to the first non-option arg.
    # returns [ options hash, remaining args ]
    def parse_initial_options argv
      parse_args argv do |argv, remaining_args, arg|
        argv.unshift arg
        :break
      end
    end

    # Parses +argv+ entirely.
    # returns [ options hash, all non-option args ]
    def parse argv
      parse_args argv do |argv, remaining_args, arg|
        remaining_args << arg
      end
    end

    private

    def parse_args argv
      opts = @defaults.dup
      remaining_args = []

      # handle all the args (including any that get unshifted back on)
      argv = argv.to_a.dup
      while arg = argv.shift do

        # early out when the user says so
        break if arg == "--"

        if arg =~ OPTION_PATTERN
          # look for a default value
          opt = $1.to_sym

          # detect:
          # 1) multiple short options in a row (handle recursively), or
          # 2) short option followed immediately by value
          # 3) long option with value "--opt=val" => "--opt" "val"
          if !valid_option? opt
            case arg
            when /^-([^-])(.+)/ then unshift_split_options argv, $1, $2
            when /^--([^=]+)=(.+)/ then unshift_option_value argv, $1, $2
            else raise ArgParseException, nil, "unknown option: " + arg
            end
            next
          end

          # handle boolean option
          if boolean_option? opt
            opts[canonical_option_sym opt] = true
          else
            # handle option with value
            if argv.first and argv.first !~ OPTION_PATTERN
              opts[canonical_option_sym opt] = argv.shift
            # or blow up if no value is available
            elsif required_value? opt
              raise ArgParseException, opt
            else
              raise RuntimeError, opt, "expecting default value to be set already" unless !opt[canonical_option_sym opt]
            end
          end
        else # not an option argument
          break if :break == yield(argv, remaining_args, arg)
        end
      end
      remaining_args.concat argv
      each_option do |opt_sym, opt|
        if !opts.has_key? opt_sym
          raise ArgParseException, "required option: %s" % [opt_sym] if opt.required_option?
          raise RuntimeError, "default not pre-populated for option: %s" % [opt_sym] unless opt.required_value?
        end
      end
      [ opts, remaining_args ]
    end

    # helper method that re-adds split up short options to the start of +argv+
    # for further handling
    def unshift_split_options argv, initial_boolean_option, remaining_str
      if boolean_option? initial_boolean_option.to_sym
        # boolean option, so put remaining on as option(s)
        argv.unshift "-" + remaining_str
      else
        # not a boolean option, so put remaining on as an arg
        argv.unshift remaining_str
      end

      # recurse to handle option through regular code paths
      argv.unshift "-" + initial_boolean_option
    end

    # helper method that re-adds split up --long=value option to the start of
    # +argv+ for further handling
    def unshift_option_value argv, initial_option, value_str
      # recurse to handle option through regular code paths
      argv.unshift "--" + initial_option
      argv.unshift value_str
    end

    # runs through canonical +options+ and pre-calculates the defaults hash
    def calculate_defaults
      # see http://www.ruby-forum.com/topic/185611#811055 for the source of
      # this obtuseness (basically, I wanted Hash.map, but it didn't work)
      opts_with_defaults = @options.select {|_, opt| opt.should_have_default_value? }
      opts_with_defaults.merge(opts_with_defaults) {|_, opt, _| opt.default_value }
    end

    # yields each canonical +Option+ instance to the supplied block
    def each_option
      @options.each {|opt_sym, opt| yield opt_sym, opt }
    end

    # returns true if the option is a valid one
    def valid_option? opt_sym
      @options_with_short_keys.key? opt_sym
    end

    # returns true if the value for +opt_sym+ is a boolean
    def boolean_option? opt_sym
      val = default_value opt_sym
      !!val == val
    end

    # returns true if the option for +opt_sym+ has a +:required_value+
    def required_value? opt_sym
      @options_with_short_keys[opt_sym].required_value?
    end

    # returns the option's default value
    def default_value opt_sym
      @options_with_short_keys[opt_sym].default_value
    end

    # returns the option's full name (as a symbol)
    def canonical_option_sym opt_sym
      @options_with_short_keys[opt_sym].name.to_sym
    end
  end

  class Option

    attr_accessor :ary

    # initializes a new +Option+
    def initialize name=nil, default_value=nil, *args
      block = nil
      args.reject! {|arg| block = arg if arg.kind_of? Proc}
      @ary = [ name, default_value, *args, block ]
      if !default_value.nil? != should_have_default_value?
        raise ArgumentError, "option: %s should specify a default value OR :required_value or :required_option, but NOT BOTH" % [name]
      end
    end

    def name; @ary[0]; end
    def default_value; @ary[1]; end
    def should_have_default_value?; !required_value? and !required_option? end
    def required_value?; @ary.include? :required_value; end
    def required_option?; @ary.include? :required_option; end
    def parse! arg; @ary[-1].call arg; end
  end

  class ArgParseException < RuntimeError

    attr_accessor :option

    def initialize option=nil, msg=nil
      @option = option
      if option
        super "error parsing option: %s#{" - " + msg if msg}" % [option]
      else
        super msg
      end
    end
  end

end
