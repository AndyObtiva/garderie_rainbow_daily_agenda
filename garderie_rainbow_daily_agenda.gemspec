# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in , and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: garderie_rainbow_daily_agenda 1.0.0 ruby vendor lib app

Gem::Specification.new do |s|
  s.name = "garderie_rainbow_daily_agenda".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["vendor".freeze, "lib".freeze, "app".freeze]
  s.authors = ["Andy Maleh".freeze]
  s.date = "2020-08-16"
  s.description = "Garderie Rainbow Daily Agenda".freeze
  s.email = "andy.am@gmail.com".freeze
  s.executables = ["garderie_rainbow_daily_agenda".freeze, "garderie_rainbow_daily_agenda".freeze]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md",
    "TODO"
  ]
  s.files = [
    "LICENSE.txt",
    "VERSION",
    "app/garderie_rainbow_daily_agenda.rb",
    "app/models/garderie_rainbow_daily_agenda/child.rb",
    "app/models/garderie_rainbow_daily_agenda/drink.rb",
    "app/models/garderie_rainbow_daily_agenda/email_message.rb",
    "app/models/garderie_rainbow_daily_agenda/meal.rb",
    "app/models/garderie_rainbow_daily_agenda/mood.rb",
    "app/models/garderie_rainbow_daily_agenda/potty_time.rb",
    "app/services/garderie_rainbow_daily_agenda/email_service.rb",
    "app/views/garderie_rainbow_daily_agenda/app_view.rb",
    "app/views/garderie_rainbow_daily_agenda/meal_serving_radio_group.rb",
    "app/views/garderie_rainbow_daily_agenda/preferences.rb",
    "bin/garderie_rainbow_daily_agenda",
    "package/macosx/Garderie Rainbow Daily Agenda.icns",
    "package/windows/Garderie Rainbow Daily Agenda.ico",
    "vendor/jre/bin/java",
    "vendor/jre/bin/jjs",
    "vendor/jre/bin/keytool",
    "vendor/jre/bin/orbd",
    "vendor/jre/bin/pack200",
    "vendor/jre/bin/policytool",
    "vendor/jre/bin/rmid",
    "vendor/jre/bin/rmiregistry",
    "vendor/jre/bin/servertool",
    "vendor/jre/bin/tnameserv",
    "vendor/jre/bin/unpack200",
    "vendor/org/bouncycastle/bcpkix-jdk15on/1.62/bcpkix-jdk15on-1.62.jar",
    "vendor/org/bouncycastle/bcprov-jdk15on/1.62/bcprov-jdk15on-1.62.jar",
    "vendor/org/bouncycastle/bctls-jdk15on/1.62/bctls-jdk15on-1.62.jar",
    "vendor/org/yaml/snakeyaml/1.26/snakeyaml-1.26.jar"
  ]
  s.homepage = "http://github.com/AndyObtiva/garderie_rainbow_daily_agenda".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Garderie Rainbow Daily Agenda".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<glimmer-dsl-swt>.freeze, ["~> 0.6.3"])
      s.add_runtime_dependency(%q<glimmer-cw-cdatetime-nebula>.freeze, ["~> 1.4.0.1"])
      s.add_runtime_dependency(%q<activemodel>.freeze, ["~> 5.2.4.3"])
      s.add_runtime_dependency(%q<mail>.freeze, ["~> 2.7.1"])
      s.add_runtime_dependency(%q<email_validator>.freeze, ["~> 2.0.1"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
      s.add_development_dependency(%q<git-glimmer>.freeze, ["= 1.7.0"])
      s.add_development_dependency(%q<jeweler>.freeze, ["= 2.3.9"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    else
      s.add_dependency(%q<glimmer-dsl-swt>.freeze, ["~> 0.6.3"])
      s.add_dependency(%q<glimmer-cw-cdatetime-nebula>.freeze, ["~> 1.4.0.1"])
      s.add_dependency(%q<activemodel>.freeze, ["~> 5.2.4.3"])
      s.add_dependency(%q<mail>.freeze, ["~> 2.7.1"])
      s.add_dependency(%q<email_validator>.freeze, ["~> 2.0.1"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
      s.add_dependency(%q<git-glimmer>.freeze, ["= 1.7.0"])
      s.add_dependency(%q<jeweler>.freeze, ["= 2.3.9"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<glimmer-dsl-swt>.freeze, ["~> 0.6.3"])
    s.add_dependency(%q<glimmer-cw-cdatetime-nebula>.freeze, ["~> 1.4.0.1"])
    s.add_dependency(%q<activemodel>.freeze, ["~> 5.2.4.3"])
    s.add_dependency(%q<mail>.freeze, ["~> 2.7.1"])
    s.add_dependency(%q<email_validator>.freeze, ["~> 2.0.1"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<git-glimmer>.freeze, ["= 1.7.0"])
    s.add_dependency(%q<jeweler>.freeze, ["= 2.3.9"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
  end
end

