class FileDefinition
  attr_accessor :input_path, :group_path, :output_path, :include_in_target

  def self.build(project_root, file_path)
    relative_file_path = file_path.gsub("#{File.expand_path(project_root)}/", "")
    include_in_target = !relative_file_path.match(/\.[cm]$/).nil?
     FileDefinition.new({
      :input_path => relative_file_path,
      :group_path => File.dirname(relative_file_path),
      :output_path => relative_file_path,
      :include_in_target => include_in_target
    })
  end

  def initialize(options)
    @input_path = options[:input_path]
    @group_path = options[:group_path]
    @output_path = options[:output_path]
    @include_in_target = options[:include_in_target]
  end

  def include_in_target?
    @include_in_target
  end
end
