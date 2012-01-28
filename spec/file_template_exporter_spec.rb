require "file_template_exporter"
require "file_template"
require "file_definition"

describe FileTemplateExporter do
  it "has a filename" do
    FileTemplateExporter.new(FileTemplate.new({})).filename.should == "TemplateInfo.plist"
  end

  context "to_xml with no file definitions" do
    before(:each) do
      @file_template = FileTemplate.new({:identifier => "some project"})
      @exporter = FileTemplateExporter.new(@file_template)
      EmptyTemplate.stub!(:read).and_return("")
    end

    it "reads the empty template" do
      EmptyTemplate.should_receive(:read).with("file_template").and_return("")

      @exporter.to_xml
    end

    it "includes only the identifier" do
      EmptyTemplate.stub!(:read).with("file_template").and_return("{{IDENTIFIER}}")

      @exporter.to_xml.should == "some project"
    end

    it "includes the identifier with other surrounding text" do
      EmptyTemplate.stub!(:read).with("file_template").and_return("Identifier: {{IDENTIFIER}}")

      @exporter.to_xml.should == "Identifier: some project"
    end

    it "replaces the FILE_DEFINITIONS with nothing" do
      EmptyTemplate.stub!(:read).with("file_template").and_return("{{FILE_DEFINITIONS}}")

      @exporter.to_xml.should == ""
    end

    it "replaces the file definition list with nothing" do
      EmptyTemplate.stub!(:read).with("file_template").and_return("{{FILE_DEFINITIONS_LIST}}")

      @exporter.to_xml.should == ""
    end
  end

  context "to_xml with one file definition" do
    before(:each) do
      @file_template = FileTemplate.new({:identifier => "some project"})
      @file_definition = FileDefinition.new({
        :input_path => "some/input/path",
        :group_path => "group",
        :output_path => "some/output/path",
        :include_in_target => true
      })
      @file_template.stub!(:file_definitions).and_return([@file_definition])
      @exporter = FileTemplateExporter.new(@file_template)
      EmptyTemplate.stub!(:read).and_return("")
      EmptyTemplate.stub!(:read).with("file_template").and_return("{{FILE_DEFINITIONS}}")
    end

    it "includes the input path" do
      EmptyTemplate.stub!(:read).with("file_definition").and_return("{{INPUT_PATH}}")

      @exporter.to_xml.should == "some/input/path"
    end

    it "includes the output path" do
      EmptyTemplate.stub!(:read).with("file_definition").and_return("{{OUTPUT_PATH}}")

      @exporter.to_xml.should == "some/output/path"
    end

    it "includes a one level group" do
      EmptyTemplate.stub!(:read).with("file_definition").and_return("{{GROUP_PATH}}")

      @exporter.to_xml.should == "<string>group</string>"
    end

    it "includes a two level group" do
      @file_definition.group_path = "group/path"
      EmptyTemplate.stub!(:read).with("file_definition").and_return("{{GROUP_PATH}}")

      @exporter.to_xml.should == "<string>group</string>\n<string>path</string>"
    end

    it "includes one file in the file definition list" do
      EmptyTemplate.stub!(:read).with("file_template").and_return("{{FILE_DEFINITIONS_LIST}}")

      @exporter.to_xml.should == "<string>some/input/path</string>"
    end
  end

  context "to_xml with two file definitions" do
    before(:each) do
      @file_template = FileTemplate.new({:identifier => "some project"})
      @file_definition1 = FileDefinition.new({:input_path => "input1", :group_path => "group",
                                             :output_path => "output1", :include_in_target => true})
      @file_definition2 = FileDefinition.new({:input_path => "input2", :group_path => "group",
                                             :output_path => "output2", :include_in_target => true})
      @file_template.stub!(:file_definitions).and_return([@file_definition1, @file_definition2])
      @exporter = FileTemplateExporter.new(@file_template)
      EmptyTemplate.stub!(:read).and_return("")
      EmptyTemplate.stub!(:read).with("file_template").and_return("{{FILE_DEFINITIONS}}")
    end

    it "includes both of them in the FILE_DEFINITIONS section" do
      EmptyTemplate.stub!(:read).with("file_definition").and_return("{{INPUT_PATH}}:{{OUTPUT_PATH}}","{{INPUT_PATH}}:{{OUTPUT_PATH}}")

      @exporter.to_xml.should == "input1:output1\ninput2:output2"
    end

    it "includes both input paths in the FILE_DEFINITIONS_LIST section" do
      EmptyTemplate.stub!(:read).with("file_template").and_return("{{FILE_DEFINITIONS_LIST}}")

      @exporter.to_xml.should == "<string>input1</string>\n<string>input2</string>"
    end
  end
end

#
# <?xml version="1.0" encoding="UTF-8"?>
# <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
# <plist version="1.0">
#   <dict>
#     <key>Identifier</key>
#     <string>com.ericmeyer.ocslim</string>
#     <key>Kind</key>
#     <string>Xcode.Xcode3.ProjectTemplateUnitKind</string>
#     <key>Definitions</key>
#     <dict>
#       <key>cslim/src/ExecutorObjectiveC/StatementExecutor.m</key>
#       <dict>
#         <key>Group</key>
#         <array>
#           <string>OCSlim</string>
#           <string>ExecutorObjectiveC</string>
#         </array>
#         <key>Path</key>
#         <string>cslim/src/ExecutorObjectiveC/StatementExecutor.m</string>
#       </dict>
#     </dict>
#
#     <key>Nodes</key>
#     <array>
#       <string>cslim/src/ExecutorObjectiveC/StatementExecutor.m</string>
#     </array>
#   </dict>
# </plist>