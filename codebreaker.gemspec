# frozen_string_literal: true

require_relative 'lib/codebreaker/version'

Gem::Specification.new do |spec|
  spec.name = 'codebreaker'
  spec.version = Codebreaker::VERSION
  spec.authors = ['Konstantin Yatsenko']
  spec.email = ['moahtdeep@gmail.com']

  spec.summary = 'Codebreaker is a simple game to guess the secret code'
  spec.description = 'Codebreaker game'
  spec.homepage = 'https://github.com/cyahtzee/codebreaker'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0'

  spec.metadata['allowed_push_host'] = "TODO: Set to your gem server 'https://example.com'"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/cyahtzee/codebreaker'
  spec.metadata['changelog_uri'] = 'https://github.com/cyahtzee/codebreaker'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'bundler'
  spec.add_dependency 'fasterer'
  spec.add_dependency 'ffaker'
  spec.add_dependency 'i18n'
  spec.add_dependency 'pry'
  spec.add_dependency 'rake'
  spec.add_dependency 'rspec'
  spec.add_dependency 'rubocop'
  spec.add_dependency 'rubocop-rspec'
  spec.add_dependency 'simplecov'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
