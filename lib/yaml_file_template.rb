require "file_template"
require "yaml"

class YAMLFileTemplate

  def self.load_from_yaml(yaml)
    # move to FileTemplate.new(YAML.load(yaml))
    parsed_options = YAML.load(yaml)
    file_template = FileTemplate.new({
      :identifier => parsed_options["identifier"],
      :project_root => parsed_options["project_root"]
    })
    parsed_options["included_dirs"].each do |dir|
      file_template.include_dir(dir)
    end
    return file_template
  end

end