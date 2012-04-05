require "file_definition"

class FileTemplate
  attr_reader :identifier, :project_root, :kind, :file_definitions, :excluded_files

  def initialize(options)
    @identifier = options[:identifier]
    @project_root = options[:project_root]
    @kind = "Xcode.Xcode3.ProjectTemplateUnitKind"
    @file_definitions = []
    @excluded_files = options[:excluded_files]
  end

  def include_dir(path)
    files_in_dir(path).each do |path|
      @file_definitions << FileDefinition.build(project_root, path)
    end
  end

  private

  def files_in_dir(path)
    full_path = path.match(/^\//) ? path : File.join(project_root, path)
    files = Dir.glob(File.join(full_path, "**/*")).reject { |path| File.directory? path }
    files.reject {|path| excluded_files.include?(File.split(path)[1]) }
  end
end
