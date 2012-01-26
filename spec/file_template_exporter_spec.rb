require "file_template_exporter"
require "file_template"
require "file_definition"

describe FileTemplateExporter do
  it "has a filename" do
    FileTemplateExporter.new(FileTemplate.new({})).filename.should == "TemplateInfo.plist"
  end

  context "to_xml" do
    before(:each) do
      @exporter = FileTemplateExporter.new(FileTemplate.new({:identifier => "some project"}), "/some/dir")
    end

    it "reads the empty template" do
      File.should_receive(:read).with("/some/dir/file_template.xml").and_return("")

      @exporter.to_xml
    end

    it "includes only the identifier" do
      File.stub!(:read).with("/some/dir/file_template.xml").and_return("{{IDENTIFIER}}")

      @exporter.to_xml.should == "some project"
    end

    it "includes the identifier with other surrounding text" do
      File.stub!(:read).with("/some/dir/file_template.xml").and_return("Identifier: {{IDENTIFIER}}")

      @exporter.to_xml.should == "Identifier: some project"
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