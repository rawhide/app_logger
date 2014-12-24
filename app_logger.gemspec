$:.push File.expand_path("../lib", __FILE__)

require 'app_logger/version'

Gem::Specification.new do |spec|
  spec.name          = "app_logger"
  spec.version       = AppLogger::VERSION
  spec.authors       = ["RAWHIDE. Co., Ltd."]
  spec.email         = ["info@raw-hide.co.jp"]
  spec.description   = %q{output log}
  spec.summary       = %q{output log with color}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "activesupport", "~> 3.0"
  spec.add_dependency "term-ansicolor"
end
