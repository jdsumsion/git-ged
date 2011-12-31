Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  $:.unshift(File.dirname(__FILE__))
  require 'lib/git-ged'

  s.name              = 'git-ged'
  s.version           = GitGed::VERSION
  s.date              = '2011-12-30'
  #s.rubyforge_project = 'git-ged'

  s.summary     = "GEDCOM plugin for Git"
  s.description = "git-ged is a Ruby toolset for managing genealogical data (GEDCOM) inside a Git reposity."

  s.authors  = ["John Sumsion"]
  s.email    = 'jdsumsion@gmail.com'
  s.homepage = 'http://github.com/jdsumsion/git-ged'

  s.require_paths = %w[lib]

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md LICENSE LICENSE.grit TODO layout.txt]

  s.add_dependency('grit', "~> 2.4.1")
  s.add_dependency('subcommand', "~> 1.0.6")

  s.add_development_dependency('mocha')

  s.executables << 'git-ged'

  # = MANIFEST =
  s.files = %w[
    LICENSE
    LICENSE.grit
    README.md
    Rakefile
    TODO
    bin/git-ged
    git-ged.gemspec
    layout.txt
    lib/git-ged.rb
    lib/git-ged/attach_cmd.rb
    lib/git-ged/clone_cmd.rb
    lib/git-ged/cmd_support.rb
    lib/git-ged/commit_cmd.rb
    lib/git-ged/fetch_cmd.rb
    lib/git-ged/help_cmd.rb
    lib/git-ged/import_cmd.rb
    lib/git-ged/ingest_cmd.rb
    lib/git-ged/init_cmd.rb
    lib/git-ged/push_cmd.rb
    lib/git-ged/repo.rb
    lib/git-ged/workspace_cmd.rb
  ]
  # = MANIFEST =

  s.test_files = s.files.select { |path| path =~ /^test\/test_.*\.rb/ }
end
