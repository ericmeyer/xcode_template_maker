require "nokogiri"
EMPTY_TEMPLATE_DIR = File.expand_path(File.join(File.dirname(__FILE__), "empty_templates"))

class FileTemplateExporter
  attr_reader :filename

  def initialize(file_template, empty_template_dir=EMPTY_TEMPLATE_DIR)
    @empty_template_dir = empty_template_dir
    @file_template = file_template
    @filename = "TemplateInfo.plist"
  end

  def to_xml
    File.read(File.join(@empty_template_dir, "file_template.xml")).gsub("{{IDENTIFIER}}", @file_template.identifier)
  end
end