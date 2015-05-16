# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gameday_api/version', __FILE__)

Gem::Specification.new do |spec|
  spec.authors       = ["Colin Shevlin"]
  spec.email         = ["cwshevlin@gmail.com"]
  spec.description   = %q{An API for processing MLB statistics and information.}
  spec.summary       = %q{Abanico}
  spec.homepage      = %q{https://github.com/cwshevlin/abanico}

  spec.files         = `git ls-files`.split($\)
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.name          = "gameday_api"
  spec.require_paths = ["lib"]
  spec.version       = GamedayApi::VERSION

  spec.add_dependency 'nokogiri'
end
