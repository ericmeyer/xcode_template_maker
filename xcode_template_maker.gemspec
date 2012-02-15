spec = Gem::Specification.new do |s|
  s.name        = "xcode_template_maker"
  s.version     = "0.0.3"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Eric Meyer"]
  s.email       = ["emeyer@8thlight.com"]
  s.homepage    = "https://github.com/ericmeyer/xcode_template_maker"
  s.summary     = %q{Much easier way to create templates for Xcode than editing the xml}
  s.description = %q{Much easier way to create templates for Xcode than editing the xml}
  s.rubyforge_project = "xcode_template_maker"
  s.files         = Dir.glob('lib/**/*')
  s.require_paths = ["lib"]
  s.bindir = 'bin'
  s.executables = ['export_xcode_file_list']
end
