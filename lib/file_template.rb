class FileTemplate
  class FileDefinition
    attr_reader :input_path, :group_path, :output_path
    def initialize(input_path, group_path, output_path, include_in_target)
      @input_path = input_path
      @group_path = group_path
      @output_path = output_path
      @include_in_target = include_in_target
    end
    
    def include_in_target?
      @include_in_target
    end
  end
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
      @file_definitions << FileDefinition.new(relative_path, File.dirname(path).gsub("#{template_root}/", ""), relative_path, include_in_target)
    end
  end
end