require "file_template"

describe FileTemplate do
  before(:each) do
    @file_template = FileTemplate.new({
      :identifier => "com.bob.project",
      :project_root => "/path/to/project"
    })
  end

  it "has an identifier" do
    @file_template.identifier.should == "com.bob.project"
  end

  it "has a template root" do
    @file_template.project_root.should == "/path/to/project"
  end

  it "has a kind" do
    @file_template.kind.should == "Xcode.Xcode3.ProjectTemplateUnitKind"
  end

  it "reads the contents of a directory" do
    Dir.should_receive(:glob).with("/path/to/project/files/**/*").and_return([])

    @file_template.include_dir("/path/to/project/files/")
  end

  it "works with a relative file path" do
    Dir.should_receive(:glob).with("/path/to/project/files/**/*").and_return([])

    @file_template.include_dir("files/")
  end

  context '#files' do
    it "has none to start" do
      @file_template.file_definitions.should == []
    end

    context "adding a single *.h file in the root dir" do
      before(:each) do
        Dir.stub!(:glob).and_return(["/path/to/project/dir/foo.h"])
        @file_template.include_dir("/path/to/project/dir")
      end

      it "adds a single *.h file in the root dir" do
        @file_template.file_definitions.size.should == 1
      end

      it "has an input_path for the *.h file" do
        @file_template.file_definitions[0].input_path.should == "dir/foo.h"
      end

      it "has a group path for the *.h file" do
        @file_template.file_definitions[0].group_path.should == "dir"
      end

      it "has an output_path for the *.h file" do
        @file_template.file_definitions[0].output_path.should == "dir/foo.h"
      end

      it "does not include the *.h file in the target" do
        @file_template.file_definitions[0].include_in_target?.should == false
      end
    end

    context "adding other files" do
      it "does include the *.m file in the target" do
        Dir.stub!(:glob).and_return(["/path/to/project/dir/foo.m"])
        @file_template.include_dir("/path/to/project/dir")

        @file_template.file_definitions[0].include_in_target?.should == true
      end

      it "does include the *.c file in the target" do
        Dir.stub!(:glob).and_return(["/path/to/project/dir/foo.c"])
        @file_template.include_dir("/path/to/project/dir")

        @file_template.file_definitions[0].include_in_target?.should == true
      end

      it "does not include a different file in the target" do
        Dir.stub!(:glob).and_return(["/path/to/project/dir/foo.bar"])
        @file_template.include_dir("/path/to/project/dir")

        @file_template.file_definitions[0].include_in_target?.should == false
      end
    end
  end
end