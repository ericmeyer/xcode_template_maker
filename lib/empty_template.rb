EMPTY_TEMPLATE_DIR = File.expand_path(File.join(File.dirname(__FILE__), "empty_templates"))

class EmptyTemplate
  def self.read(template_name)
    File.read(File.join(EMPTY_TEMPLATE_DIR, "#{template_name}.xml"))
  end
end