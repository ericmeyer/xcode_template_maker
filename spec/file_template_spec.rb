require "file_template"
require "fileutils"
require 'fakefs/spec_helpers'

describe FileTemplate do
  include FakeFS::SpecHelpers

  before(:each) do
    FakeFS::FileSystem.clear
    FileUtils.mkdir_p("/path/to/project")
    @file_template = FileTemplate.new({
      :identifier => "com.bob.project",
      :project_root => "/path/to/project",
      :excluded_files => ['bad_juju.h']
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

  context '#file_definitions' do
    it "has none to start" do
      @file_template.file_definitions.should == []
    end

    context "adding a single *.h file in the root dir" do
      before(:each) do
        FileUtils.mkdir_p("/path/to/project/dir")
        FileUtils.touch("/path/to/project/dir/foo.h")
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
      before(:each) do
        FileUtils.mkdir_p("/path/to/project/dir")
      end

      it "does include the *.m file in the target" do
        FileUtils.touch("/path/to/project/dir/foo.m")
        @file_template.include_dir("/path/to/project/dir")

        @file_template.file_definitions[0].include_in_target?.should == true
      end

      it "does include the *.c file in the target" do
        FileUtils.touch("/path/to/project/dir/foo.c")
        @file_template.include_dir("/path/to/project/dir")

        @file_template.file_definitions[0].include_in_target?.should == true
      end

      it "does not include a different file in the target" do
        FileUtils.touch("/path/to/project/dir/foo.bar")

        @file_template.include_dir("/path/to/project/dir")
        @file_template.file_definitions[0].include_in_target?.should == false
      end
    end

    context "glob returns nested directories" do
      it "doesn't inlcude a single directory" do
        FileUtils.mkdir_p "/path/to/project/nested/directory"
        @file_template.include_dir("/path/to/project/nested")

        @file_template.file_definitions.should == []
      end
    end

    context "excluding files" do
      it "doesnt include any files that are excluded" do
        FileUtils.mkdir_p "/path/to/project/dir"
        FileUtils.touch("/path/to/project/dir/bad_juju.h")
        @file_template.include_dir("/path/to/project/dir")

        @file_template.file_definitions.should == []
      end
    end
  end
end
