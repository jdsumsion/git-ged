require './argable'
require 'test/unit'

class ArgableTest < Test::Unit::TestCase

  def test_parses_initial_boolean_option
    a = Argable::ArgParser.new :verbose_v => true
    options, args = a.parse_initial_options %w{ --verbose arg1 --verbose }

    assert options[:verbose]
    assert args == [ "arg1", "--verbose" ]
  end

  def test_parses_initial_short_option
    a = Argable::ArgParser.new :verbose_v => true
    options, args = a.parse_initial_options %w{ -v arg1 -v }

    assert options[:verbose]
    assert args == [ "arg1", "-v" ]
  end

  def test_parses_initial_multiple_short_options
    a = Argable::ArgParser.new :recurse_r => false, :force_f => false
    options, args = a.parse_initial_options %w{ -rf arg1 -rf }

    assert options[:recurse]
    assert options[:force]
    assert args == [ "arg1", "-rf" ]
  end

  def test_parses_initial_options_stops
    a = Argable::ArgParser.new :force_f => false
    options, args = a.parse_initial_options %w{ -- -rf arg1 -rf }

    assert false == options[:force]
    assert args == [ "-rf", "arg1", "-rf" ]
  end

  def test_parses_initial_option_with_value
    a = Argable::ArgParser.new :file_f => [ nil, :required_value ]
    options, args = a.parse_initial_options %w{ --file abc arg }

    assert "abc" == options[:file]
    assert args == [ "arg" ]
  end

  def test_parses_initial_short_option_with_value
    a = Argable::ArgParser.new :file_f => [ nil, :required_value ]
    options, args = a.parse_initial_options %w{ -f abc arg }

    assert "abc" == options[:file]
    assert args == [ "arg" ]
  end

  def test_parses_initial_ambiguous_value
    a = Argable::ArgParser.new :search_S => [ nil, :required_value ], :recurse_r => false
    options, args = a.parse_initial_options %w{ -Sr arg }

    assert "r" == options[:search]
    assert false == options[:recurse]
    assert args == [ "arg" ]
  end

  def test_parse_fails_without_required_option
    assert_raise Argable::ArgParseException do
      a = Argable::ArgParser.new :version_v => [ nil, :required_option ]
      options, args = a.parse_initial_options []
      raise "should have failed without required option"
    end
  end

  def test_parse_fails_without_required_value
    assert_raise Argable::ArgParseException do
      a = Argable::ArgParser.new :file_f => [ nil, :required_value ]
      options, args = a.parse_initial_options %w{ -f }
      raise "should have failed without required value"
    end
  end

  def test_parses_non_sym_option
    a = Argable::ArgParser.new "v" => true
    options, args = a.parse_initial_options %w{ -v }
    assert options[:v]
  end

  def test_parses_enum
    a = Argable::ArgParser.new :verbose_v => true
    options, _ = a.parse_initial_options %w{ -v }.each
    assert options[:verbose]
  end

  def test_default_value
    a = Argable::ArgParser.new :verbose_v => true
    options, _ = a.parse_initial_options []
    assert options[:verbose]
  end

  def test_instantiate_requires_option_template
    assert_raise ArgumentError do
      Argable::ArgParser.new
    end
  end

  def test_instantiate_with_option_template
    assert_nothing_raised ArgumentError do
      Argable::ArgParser.new Hash.new
    end
  end
end
