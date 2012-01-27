require "file_definition"

class FileTemplate
  attr_reader :identifier, :project_root, :kind, :file_definitions

  def initialize(options)
    @identifier = options[:identifier]
    @project_root = options[:project_root]
    @kind = "Xcode.Xcode3.ProjectTemplateUnitKind"
    @file_definitions = []
  end

  def include_dir(path)
    files_in_dir(path).each do |path|
      @file_definitions << FileDefinition.build(project_root, path)
    end
  end

  private

  def files_in_dir(path)
    full_path = path.match(/^\//) ? path : File.join(project_root, path)
    Dir.glob(File.join(full_path, "**/*"))
  end
end