$:.unshift "."
require 'argable'

class ExampleCLI
  include Argable

  def initialize
    initialize_options(
      "message_m" => [ nil, :required_value ],
      "license_l" => "CC-BY-SA-3.0",
      "version_v" => false,
      "help_h" => false,
    )
  end

  def run situation, argv
    puts situation
    puts situation.gsub /./, "="
    puts "cli: %s" % argv.inspect
    options, args = parse argv
    puts "options: %s" % options.inspect
    puts "args: %s" % args.inspect
    puts
  end

  def run_examples
    run "Example with NO args", []
    run "Example of help (long)", %w{ --help }
    run "Example of version (short)", %w{ -v }
    run "Example of license (override)", %w{ --license CC-BY-3.0 }
    run "Example of message (required value)", [ "-m", "Here is a commit message" ]
    run "Example of args & options", %w{ --license CC-BY-3.0 new-repo }
  end
end

ExampleCLI.new.run_examples

__END__

Example with NO args
====================
cli: []
options: {:license=>"CC-BY-SA-3.0", :version=>false, :help=>false}
args: []

Example of help (long)
======================
cli: ["--help"]
options: {:license=>"CC-BY-SA-3.0", :version=>false, :help=>true}
args: []

Example of version (short)
==========================
cli: ["-v"]
options: {:license=>"CC-BY-SA-3.0", :version=>true, :help=>false}
args: []

Example of license (override)
=============================
cli: ["--license", "CC-BY-3.0"]
options: {:license=>"CC-BY-3.0", :version=>false, :help=>false}
args: []

Example of message (required value)
===================================
cli: ["-m", "Here is a commit message"]
options: {:license=>"CC-BY-SA-3.0", :version=>false, :help=>false, :message=>"Here is a commit message"}
args: []

Example of args & options
=========================
cli: ["--license", "CC-BY-3.0", "new-repo"]
options: {:license=>"CC-BY-3.0", :version=>false, :help=>false}
args: ["new-repo"]

