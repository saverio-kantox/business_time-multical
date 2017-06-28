# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "business_time_multical/version"

Gem::Specification.new do |s|
  s.name = "business_time-multical"
  s.version = BusinessTimeMultical::VERSION
  s.summary = %Q{Extend business_time to allow easier dynamic holidays}
  s.description = %Q{Have you ever wanted to use different holiday calendars? At the same time? Now you can!}
  s.homepage = "https://github.com/kantox/business_time-multical"
  s.authors = ['Kantox LTD']
  s.email = ["saverio.trioni@kantox.com", 'aleksei.matiushkin@kantox.com', 'david.lozano@kantox.com']
  s.license = "MIT"

  s.files = `git ls-files -z`.split("\x0").reject { |f| f.match(/(test|spec|features)\//) }
  s.require_paths = %w(lib)

  s.add_dependency('business_time')

  s.add_development_dependency "rake", '~> 10'
  s.add_development_dependency "rubocop"
  s.add_development_dependency "rdoc", '~> 4'
  s.add_development_dependency "minitest", '~> 5'
  s.add_development_dependency "minitest-rg", '~> 5'
  s.add_development_dependency "minitest-reporters", '~> 1'
  s.add_development_dependency "simplecov"
  s.add_development_dependency "byebug"
end
