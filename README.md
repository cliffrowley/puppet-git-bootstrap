# IMPORTANT NOTE

This project is now retired and unmaintained. I consider this code public domain, so please feel free to do whatever you like with it.

# Puppet Git Bootstrap

Bootstraps a node with an opinionated Git based Puppet workflow.

## IMPORTANT NOTE

Puppet Git Bootstrap is still a work in progress and is **NOT YET READY FOR PRODUCTION**. Feel free to use it, hack it, and to submit pull requests, and you can perhaps feel somewhat reassured that I am using it myself - but you have been warned. Anything that goes horribly wrong is your responsibility.

## Description

The workflow is a familiar one for those of us that don't have a whole bunch of servers to administer, via a Git repository and a post-receive hook on each node.

Uses the awesome Puppet bootstrap scripts from [hashicorp/puppet-bootstrap](https://github.com/hashicorp/puppet-bootstrap).

## Installing

Currently this gem is not available via Rubygems, so you must include it in your Gemfile like so:

```ruby
gem 'puppet-git-bootstrap', github: 'cliffrowley/puppet-git-bootstrap'
```

I heartily recommend using RVM and Bundler if you aren't already.

## Using

Bootstrapping a node involves:

* Installing the latest stable version of Git and Puppet
* Creating an empty Git repository at `/var/lib/puppet/git`
* Installing a script at `/usr/local/bin/puppet-git-apply`

### Remote nodes

To bootstrap a node, simply execute:

```sh
puppet git-bootstrap <user@host>
```

### Vagrant

Bootstrapping a Vagrant VM requires a couple of extra arguments.  Run `vagrant ssh-config` to determine the port your VM is port forwarding for ssh and then run:

```sh
puppet git-bootstrap vagrant@localhost -p <port> -i $HOME/.vagrant.d/insecure_private_key
```

## Updating

Occasionally the remote script or configuration may need to be updated. The bootstrap itself is idempotent, so running it again will perform any updates that are required.

## Contributing

Please feel free to submit pull requests through Github.
