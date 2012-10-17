require 'rubygems/package_task'

PKG_NAME = "artisan-memory-repository"
PKG_VERSION   = "0.0.3"

spec = Gem::Specification.new do |s|
  s.name = PKG_NAME
  s.version = PKG_VERSION
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

Gem::PackageTask.new(spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end

namespace :gem do
  desc "Push the gem to server"
  task :deploy => [:gem] do
    system "gem push pkg/#{PKG_NAME}-#{PKG_VERSION}.gem"
  end
end

