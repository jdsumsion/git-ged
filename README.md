git-ged
=======

* Status: experimental
* Author: John Sumsion
* Inspiration: Git, Tim Shadel

GEDCOM plugin for Git.  As a `git` subcommand, git-ged lets you import and
manage GEDCOM files in a versioned, shareable way in a Git repository.

It is also possible to attach to other repositories and fetch related
genealogy data from others who have imported it into their own repository.

As a library, git-ged lets you write programs that communicate genealogical
data in the git-ged repository layout.

As a repository implementation, git-ged also defines a [repository
specification][LAYOUT] that, if adhered to by alternate implementations will
allow all implementations to share repositories with each other.

Options for data format that I can see:
* [FOLG Gedcom][FOLG]
* [GEDCOMX][]

The initial goal is to be able to easily ingest GEDCOMs from the wild.

Support for versioned media importing is not included in the first pass,
although with projects like [git-annex][] a sharable media repository is
potentially possible.

NOTE: Although I started git-ged and have worked on it while being employed
by FamilySearch, this project is not endorsed and is not supported in any
way by FamilySearch.  I work on it outside of work hours, and do not use
internal FamilySearch servers or data privileges.  It is a personal endeavor
to enrich the genealogy data sharing ecosystem.

[LAYOUT]: https://github.com/jdsumsion/git-ged/blob/master/LAYOUT.md
[FOLG]: https://github.com/DallanQ/Gedcom/wiki/UML-Diagrams
[GEDCOMX]: http://www.gedcomx.org/Data-Model.html
[git-annex]: http://git-annex.branchable.com/

## Requirements

* git (http://git-scm.com) tested with 1.7.8
* grit gem (https://github.com/mojombo/grit) tested with 2.4.1


## Install

Easiest install is via RubyGems:

    $ gem install git-ged


## Source

Git-ged's Git repo is available on GitHub, which can be browsed at:

    https://github.com/jsumsiong/git-ged

and cloned with:

    git clone https://github.com/jsumsiong/git-ged.git


### Development

You will need these gems to get tests to pass:

* mocha


### Contributing

If you'd like to hack on git-ged, follow these instructions. To get all of the
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
