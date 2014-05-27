# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puppet-git-bootstrap/version'

Gem::Specification.new do |spec|
  spec.name          = 'puppet-git-bootstrap'
  spec.version       = PuppetGitBootstrap::VERSION
  spec.authors       = ['Cliff Rowley']
  spec.email         = ['cliffrowley@gmail.com']
  spec.summary       = %q{Bootstraps a node with an opinionated Git based Puppet workflow.}
  spec.description   = %q{Bootstraps a node with an opinionated Git based Puppet workflow.}
  spec.homepage      = 'https://github.com/cliffrowley/puppet-git-bootstrap.git'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'trollop', '~> 2.0'
  spec.add_dependency 'sshkit',  '~> 1.3'
  spec.add_dependency 'rake',    '>= 10.0.0'

  # spec.add_development_dependency 'rspec', '~> 2.14'
end
