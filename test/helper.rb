require File.join(File.dirname(__FILE__), *%w[.. lib git-ged])

require 'test/unit'
gem "mocha", ">=0"
require 'mocha'

GIT_GED_REPO = ENV["GIT_GED_REPO"] || File.expand_path(File.join(File.dirname(__FILE__), '..'))

include GitGed

def fixture(name)
  File.read(File.join(File.dirname(__FILE__), 'fixtures', name))
end

def absolute_project_path
  File.expand_path(File.join(File.dirname(__FILE__), '..'))
end

def jruby?
  defined?(RUBY_ENGINE) && RUBY_ENGINE =~ /jruby/
end
