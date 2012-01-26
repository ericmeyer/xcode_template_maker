require "file_definition"

class FileTemplate
  attr_reader :identifier, :template_root, :kind, :file_definitions

  def initialize(options)
    @identifier = options[:identifier]
    @template_root = options[:template_root]
    @kind = "Xcode.Xcode3.ProjectTemplateUnitKind"
    @file_definitions = []
  end
  
  def include_dir(path)
    full_path = path.match(/^\//) ? path : File.join(template_root, path)
    Dir.glob(File.join(full_path, "**/*")).each do |path|
      relative_path = path.gsub("#{template_root}/", "")
      include_in_target = !path.match(/\.[cm]$/).nil?
      @file_definitions << FileDefinition.new({
        :input_path => relative_path,
        :group_path => File.dirname(path).gsub("#{template_root}/", ""),
        :output_path => relative_path,
        :include_in_target => include_in_target
      })
    end
  end
end