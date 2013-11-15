require "bundler/gem_tasks"
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'coveralls/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = "--color --format documentation"
end

Coveralls::RakeTask.new

task :default => [:spec, :features, 'coveralls:push']
