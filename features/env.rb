PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))
$: << File.join(PROJECT_ROOT, "lib")
require 'cucumber/rspec/doubles'