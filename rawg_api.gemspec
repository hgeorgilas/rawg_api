require_relative 'lib/rawg_api/version'

Gem::Specification.new do |spec|
  spec.name = "rawg_api"
  spec.version = RawgApi::VERSION
  spec.authors = ["Harry Georgilas"]
  spec.email = ["harrygeorgilas@gmail.com"]

  spec.summary = %q{Rawg.io API ruby wrapper}
  spec.description = %q{A ruby API wrapper for rawg.io API v1.0}
  spec.homepage = "https://github.com/hgeorgilas/rawg_api"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'api_struct', '~> 1.0', '>= 1.0.5'
  spec.add_dependency 'dotenv'
  spec.add_dependency 'dry-configurable', '~> 0.9.0'
  spec.add_dependency 'dry-monads', '~> 1.3', '>= 1.3.5'
  spec.add_dependency 'hashie', '~> 4.1'


  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'vcr', '~> 3.0', '>= 3.0.1'
  spec.add_development_dependency 'pry-byebug', '~> 3.7'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'httplog'
  spec.add_development_dependency 'webmock'

end
