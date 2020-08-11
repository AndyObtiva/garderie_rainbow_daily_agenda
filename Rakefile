# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'glimmer/launcher'
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "garderie_rainbow_daily_agenda"
  gem.homepage = "http://github.com/AndyObtiva/garderie_rainbow_daily_agenda"
  gem.license = "MIT"
  gem.summary = %Q{Garderie Rainbow Daily Agenda}
  gem.description = %Q{Garderie Rainbow Daily Agenda}
  gem.email = "andy.am@gmail.com"
  gem.authors = ["Andy Maleh"]
  gem.files = Dir['VERSION', 'LICENSE.txt', 'lib/**/*', 'app/**/*', 'bin/**/*', 'vendor/**/*', 'package/**/*']
  gem.executables = ['garderie_rainbow_daily_agenda', 'garderie_rainbow_daily_agenda']
  gem.require_paths = ['vendor', 'lib', 'app']
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
  spec.ruby_opts = [Glimmer::Launcher.jruby_swt_options]
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['spec'].execute
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "garderie_rainbow_daily_agenda #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'glimmer/rake_task'
Glimmer::Package.javapackager_extra_args =
  " -name 'Garderie Rainbow Daily Agenda'" +
  " -title 'Garderie Rainbow Daily Agenda'" +
  " -Bmac.CFBundleName='Garderie Rainbow Daily Agenda'" +
  " -Bmac.CFBundleIdentifier='org.garderierainbowdailyagenda.application.garderierainbowdailyagenda'" 
  # " -BlicenseType=" +
  # " -Bmac.category=" +
  # " -Bmac.signing-key-developer-id-app="
