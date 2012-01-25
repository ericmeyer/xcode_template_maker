require 'rspec/core/rake_task'
require 'cucumber/rake/task'

desc 'Default: run specs.'
task :default => [:spec, :cucumber]

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
end

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = "features --format pretty"
end