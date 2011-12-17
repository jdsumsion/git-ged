git-ged
=======

Status: experimental
Author: John Sumsion
Inspriation: Git, Tim Shadel

GEDCOM plugin for Git.  As a `git` subcommand, git-ged lets you import and
manage GEDCOM files in a versioned, shareable way in a Git repository.

It is also possible to attach to other repositories and fetch related
genealogy from others who have imported it into their own repository.

As a library, git-ged lets you write programs that communicate genealogical
data in the git-ged repository layout.

As a repository implementation, git-ged also defines a repository
specification that, if adhered to by alternate implementations will render
all implementations data-compatible with each other.

The genealogical data format for persons and relationships is yet to be
decided.  The first cut will be one that is largely one-to-one compatible
with GEDCOM 5.5.  I fully expect to change the format before this
solidifies, and I'll use whatever is the commonly-accepted format.


## Requirements

* git (http://git-scm.com) tested with 1.7.8
* grit gem (https://github.com/mojombo/grit) tested with 2.4.1


## Install

Easiest install is via RubyGems:

    $ gem install git-ged


## Source

Grit's Git repo is available on GitHub, which can be browsed at:

    https://github.com/jsumsiong/git-ged

and cloned with:

    git clone https://github.com/jsumsiong/git-ged.git


### Development

You will need these gems to get tests to pass:

* mocha


### Contributing

If you'd like to hack on Grit, follow these instructions. To get all of the
dependencies, install the gem first.

1. Fork the project to your own account
1. Clone down your fork
1. Create a thoughtfully named topic branch to contain your change
1. Hack away
1. Add tests and make sure everything still passes by running `rake`
1. If you are adding new functionality, document it in README.md
1. Do not change the version number, I will do that on my end
1. If necessary, rebase your commits into logical chunks, without errors
1. Push the branch up to GitHub
1. Send a pull request for your branch


## Usage

TODO

Copyright
---------

Copyright (c) 2011 John Sumsion. See LICENSE for details.

Portions Copyright (c) 2010 Tom Preston-Warner. See LICENSE.grit for details.  Thanks to the github folks for the inspiring Grit gem.
