class EmptyTemplate
  @@empty_template_dir = File.expand_path(File.join(File.dirname(__FILE__), "empty_templates"))
  def self.empty_template_dir=(value)
    @@empty_template_dir = value
  end

  def self.read(template_name)
    File.read(File.join(@@empty_template_dir, "#{template_name}.xml"))
  end
end