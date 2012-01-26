require "empty_template"

describe EmptyTemplate do
  it "reads a template" do
    project_root = File.expand_path(File.join(File.dirname(__FILE__), ".."))
    File.should_receive(:read).with(File.join(project_root, "lib", "empty_templates", "some_template", ".xml"))
    
    EmptyTemplate.read("some_template")
  end
  
  it "returns the read contents" do
    File.stub!(:read).and_return("template contents")
    EmptyTemplate.read("anything").should == "template contents"
  end
end