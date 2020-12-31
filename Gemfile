# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'activemodel', '~> 5.2.4.3', require: 'active_model'
gem 'email_validator', '~> 2.0.1'
gem 'ruby-serial', '1.0.3.20130731'
gem 'yasl'

group :development do
  gem 'glimmer-cw-cdatetime-nebula', '>= 1.5.0.1.1'
  gem 'glimmer-dsl-swt', '>= 4.17.2.0'
  gem 'mail', '~> 2.7.1'
  gem 'jruby-openssl', '0.10.5', git: 'https://github.com/AndyObtiva/jruby-openssl.git', ref: 'v0.10.5-fix-load-mac-app'
  gem 'mini_mime', '1.0.2', git: 'https://github.com/AndyObtiva/mini_mime.git', ref: 'v1.0.2-fix-windows-eof-issue'
end

group :development do
  gem 'rspec', '~> 3.5.0'
  gem 'git-glimmer', '1.7.0'
  gem 'jeweler', '2.3.9'
  gem 'simplecov', '>= 0'
  gem 'warbler', '2.0.5'
  gem 'glimmer-cs-gladiator'
end
