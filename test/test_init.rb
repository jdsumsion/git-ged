require File.dirname(__FILE__) + '/helper'

class TestInit < Test::Unit::TestCase

  def setup
  end

  def test_init_creates_git_repo
    Dir.mktmpdir do |tmpdir|
      Repo.new.init([tmpdir])
      assert Dir.exists?("#{tmpdir}/.git")
    end
  end

end
