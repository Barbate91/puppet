#!/usr/bin/rake -T

require 'puppetlabs_spec_helper/rake_tasks'

# For playing nice with mock
File.umask(027)

# blacksmith does not support ruby 1.8.7 anymore
require 'puppet_blacksmith/rake_tasks' if ENV['RAKE_ENV'] != 'ci' && RUBY_VERSION.split('.')[0,3].join.to_i > 187

begin
  require 'puppetlabs_spec_helper/rake_tasks'
rescue LoadError
  puts "== WARNING: Gem puppetlabs_spec_helper not found, spec tests cannot be run! =="
end

# Lint Material
begin
  require 'puppet-lint/tasks/puppet-lint'

  PuppetLint.configuration.send("disable_80chars")
  PuppetLint.configuration.send("disable_variables_not_enclosed")
  PuppetLint.configuration.send("disable_class_parameter_defaults")
rescue LoadError
  puts "== WARNING: Gem puppet-lint not found, lint tests cannot be run! =="
end

