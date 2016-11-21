# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kitchen/driver/vagrant_remote_version'

Gem::Specification.new do |spec|
  spec.name          = "kitchen-vagrant-remote"
  spec.version       = Kitchen::Driver::VAGRANT_REMOTE_VERSION
  spec.authors       = ["mzp"]
  spec.email         = ["mzpppp@gmail.com"]

  spec.summary       = "Kitchen::Driver::VagrantRemote - A Remote Vagrant Driver for Test Kitchen."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/mzp/kitchen-vagrant-remote"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "kitchen-vagrant"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
