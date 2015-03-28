# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gameday_api/version', __FILE__)

Gem::Specification.new do |spec|
  spec.authors       = ["Timothy Fisher"]
  spec.email         = ["timothyf@gmail.com"]
  spec.description   = %q{An API for processing live MLB statistics.}
  spec.summary       = %q{TODO: Write a spec summary}
  spec.homepage      = %q{http://github.com/timothyf/gameday_api}

  spec.files         = `git ls-files`.split($\)
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.name          = "gameday_api"
  spec.require_paths = ["lib"]
  spec.version       = GamedayApi::VERSION

  spec.add_dependency 'nokogiri'
end
