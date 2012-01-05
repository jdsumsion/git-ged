require File.dirname(__FILE__) + '/helper'

class TestInit < Test::Unit::TestCase

  def setup
  end

  def test_description
    assert_equal "Initializes a new git-ged repo", InitCmd.new.description
  end

end
