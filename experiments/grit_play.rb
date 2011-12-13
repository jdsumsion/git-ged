require 'grit'
require 'pp'

FileUtils.rm_rf("test.git")
repo = Grit::Repo.init_bare_or_open("test.git")
index = repo.index
index.add("hello/world/file", "contents")
pp index
repo.commit_index("my commit")
pp repo.commits
