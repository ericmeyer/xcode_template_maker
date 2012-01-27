require "yaml_file_template"

describe YAMLFileTemplate do
  context "#load_from_yaml with no included_dirs" do
    before(:each) do
      @yaml = <<YAML
identifier: some.project.ident
project_root: ../project
included_dirs: []
YAML
      @file_template = YAMLFileTemplate.load_from_yaml(@yaml)
    end

    it "gets the identifier from yaml" do
      @file_template.identifier.should == "some.project.ident"
    end

    it "gets the project root" do
      @file_template.project_root.should == "../project"
    end

    it "has no file definitions" do
      @file_template.file_definitions.should == []
    end
  end

  context "#load_from_yaml with included_dirs" do
    before(:each) do
      @yaml = <<YAML
identifier: some.project.ident
project_root: ../project
included_dirs:
- src
- lib/models
YAML
      @file_template = mock("FileTemplate", :include_dir => nil)
      FileTemplate.stub!(:new).and_return(@file_template)
    end

    it "includes the src directory" do
      @file_template.should_receive(:include_dir).with("src")

      YAMLFileTemplate.load_from_yaml(@yaml)
    end

    it "includes the lib/models directory" do
      @file_template.should_receive(:include_dir).with("lib/models")

      YAMLFileTemplate.load_from_yaml(@yaml)
    end
  end
end
