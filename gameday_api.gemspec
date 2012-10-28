# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gameday_api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Timothy Fisher"]
  gem.email         = ["timothyf@gmail.com"]
  gem.description   = %q{An API for processing live MLB statistics.}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = %q{http://github.com/timothyf/gameday_api}

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "gameday_api"
  gem.require_paths = ["lib"]
  gem.version       = GamedayApi::VERSION
end
