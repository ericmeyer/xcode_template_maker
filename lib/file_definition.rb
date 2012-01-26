class FileDefinition
  attr_reader :input_path, :group_path, :output_path
  
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
