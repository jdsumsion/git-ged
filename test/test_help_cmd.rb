require File.dirname(__FILE__) + '/helper'

class TestHelpCmd < Test::Unit::TestCase

  def setup
  end

  def test_name
    assert_equal "help", HelpCmd.new.name
  end

  def test_description
    assert_equal "Prints help for git-ged commands", HelpCmd.new.description
  end

end
