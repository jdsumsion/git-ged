require 'grit'
require 'pp'

FileUtils.rm_rf("test.git")
repo = Grit::Repo.init_bare_or_open("test.git")
tree = repo.git.write_tree #empty
repo.index.commit("first commit", { :commit_tree_sha => tree, :head => "some-branch" })
commits = repo.commits("some-branch")
pp commits

index = repo.index
index.add("hello/world/file", "contents")
index.commit("my commit", { :head => "some-branch", :parents => [commits.first] })
pp repo.commits("some-branch")
