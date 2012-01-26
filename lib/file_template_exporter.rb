require "empty_template"

class FileTemplateExporter
  attr_reader :filename

  def initialize(file_template, empty_template_dir=EMPTY_TEMPLATE_DIR)
    @empty_template_dir = empty_template_dir
    @file_template = file_template
    @filename = "TemplateInfo.plist"
  end

  def to_xml
    EmptyTemplate.read("file_template").gsub("{{IDENTIFIER}}", @file_template.identifier)
  end
end