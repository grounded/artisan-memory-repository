require 'rubygems/package_task'

pkg_name = "artisan-memory-repository"
pkg_version   = "0.0.3"

spec = Gem::Specification.new do |s|
  s.name = pkg_name
  s.version = pkg_version
  s.summary = "Artisan Memory Repository"
  s.description = "An interface to the Artisan in memory persistance layer"
  s.files = Dir.glob('lib/**/*.rb')
  s.require_path = 'lib'
  s.test_files = Dir.glob('spec/*_spec.rb')
  s.author = "8th Light Craftsmen"
  s.email = "paul@8thlight.com"
  s.homepage = "http://8thlight.com"
  s.add_dependency("activemodel", ">= 3.1.6")
end

