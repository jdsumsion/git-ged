require File.dirname(__FILE__) + '/helper'
require 'git-ged/cmd_support'

class TestHelpCmd < Test::Unit::TestCase

  class StubCmd < CmdSupport
  end

  def test_name
    assert_equal "stub", StubCmd.new.name
  end

end
