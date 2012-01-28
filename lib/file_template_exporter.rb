require "empty_template"

class FileTemplateExporter
  attr_reader :filename

  def initialize(file_template)
    @file_template = file_template
    @filename = "TemplateInfo.plist"
  end

  def to_xml
    file_template = EmptyTemplate.read("file_template")
    file_template.gsub!("{{IDENTIFIER}}", @file_template.identifier)
    file_definitions_to_xml = file_definitions.collect do |file_definition|
      file_definition_to_xml(file_definition)
    end.join("\n")
    file_template.gsub!("{{FILE_DEFINITIONS}}", file_definitions_to_xml)
    file_template.gsub!("{{FILE_DEFINITIONS_LIST}}", file_definition_list_as_xml)
    file_template
  end

  private

  def file_definition_list_as_xml
    file_definitions.collect do |file_definition|
      "<string>#{file_definition.input_path}</string>"
    end.join("\n")
  end

  def file_definition_to_xml(file_definition)
    file_definition_template = EmptyTemplate.read("file_definition")
    file_definition_template.gsub!("{{INPUT_PATH}}", file_definition.input_path)
    file_definition_template.gsub!("{{OUTPUT_PATH}}", file_definition.output_path)
    file_definition_template.gsub!("{{GROUP_PATH}}", group_path_to_xml(file_definition.group_path))
    return file_definition_template
  end

  def group_path_to_xml(group_path)
    group_path.split("/").collect {|part| "<string>#{part}</string>"}.join("\n")
  end

  def file_definitions
    @file_template.file_definitions
  end
end