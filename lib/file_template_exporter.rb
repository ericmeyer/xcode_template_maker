require "empty_template"

class FileTemplateExporter
  attr_reader :filename

  def initialize(file_template, empty_template_dir=EMPTY_TEMPLATE_DIR)
    @empty_template_dir = empty_template_dir
    @file_template = file_template
    @filename = "TemplateInfo.plist"
  end

  def to_xml
    file_template = EmptyTemplate.read("file_template")
    file_template.gsub!("{{IDENTIFIER}}", @file_template.identifier)
    file_definition = @file_template.file_definitions.first
    if file_definition
      file_definition_template = EmptyTemplate.read("file_definition")
      file_definition_template.gsub!("{{INPUT_PATH}}", file_definition.input_path)
      file_definition_template.gsub!("{{OUTPUT_PATH}}", file_definition.output_path)
      file_definition_template.gsub!("{{GROUP_PATH}}", file_definition.group_path.split("/").collect {|part| "<string>#{part}</string>"}.join("\n"))
      file_template.gsub!("{{FILE_DEFINITIONS}}", file_definition_template)
    else
      file_template.gsub!("{{FILE_DEFINITIONS}}", "")
    end
    file_template
  end
end