require 'file_definition'

describe FileDefinition, '#build' do
  context "adding a relative file path" do
    before(:each) do
      @file_definition = FileDefinition.build("/path/to/project", "dir/foo.h")
    end

    it "has an input_path for the *.h file" do
      @file_definition.input_path.should == "dir/foo.h"
    end

    it "has a group path for the *.h file" do
      @file_definition.group_path.should == "dir"
    end

    it "has an output_path for the *.h file" do
      @file_definition.output_path.should == "dir/foo.h"
    end

    it "does not include the *.h file in the target" do
      @file_definition.include_in_target?.should == false
    end
  end

  context "adding a full file path without a final slash" do
    before(:each) do
      @file_definition = FileDefinition.build("/path/to/project", "/path/to/project/dir/foo.h")
    end

    it "has an input_path for the *.h file" do
      @file_definition.input_path.should == "dir/foo.h"
    end

    it "has a group path for the *.h file" do
      @file_definition.group_path.should == "dir"
    end

    it "has an output_path for the *.h file" do
      @file_definition.output_path.should == "dir/foo.h"
    end

    it "does include the *.h file in the target" do
      @file_definition.include_in_target?.should == false
    end
  end

  context "adding a full file path with a final slash" do
    before(:each) do
      @file_definition = FileDefinition.build("/path/to/project/", "/path/to/project/dir/foo.h")
    end

    it "has an input_path for the *.h file" do
      @file_definition.input_path.should == "dir/foo.h"
    end

    it "has a group path for the *.h file" do
      @file_definition.group_path.should == "dir"
    end

    it "has an output_path for the *.h file" do
      @file_definition.output_path.should == "dir/foo.h"
    end

    it "does not include the *.h file in the target" do
      @file_definition.include_in_target?.should == false
    end
  end

  context "including file definition in target" do
    it "does not include *.h files" do
      file_definition = FileDefinition.build("/foo", "bar.h")
      file_definition.include_in_target?.should == false
    end

    it "does include *.m files" do
      file_definition = FileDefinition.build("/foo", "bar.m")
      file_definition.include_in_target?.should == true
    end

    it "does include *.c files" do
      file_definition = FileDefinition.build("/foo", "bar.c")
      file_definition.include_in_target?.should == true
    end

    it "includes .sh files" do
      file_definition = FileDefinition.build("/foo", "bar.sh")
      file_definition.include_in_target?.should == true
    end

    it "defaults to not inlcuding" do
      file_definition = FileDefinition.build("/foo", "bar.foo")
      file_definition.include_in_target?.should == false
    end
  end
end
