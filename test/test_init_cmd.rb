require File.dirname(__FILE__) + '/helper'

class TestInitCmd < Test::Unit::TestCase

  def setup
  end

  def test_description
    assert_equal "Initializes a new git-ged repo", InitCmd.new.description
  end

end
