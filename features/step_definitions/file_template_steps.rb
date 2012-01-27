require "file_template"
require "empty_template"
require "file_template_exporter"

Given /^I am creating a file template for "([^"]*)"$/ do |identifier|
  @file_template = FileTemplate.new(:identifier => identifier, :project_root => File.join(PROJECT_ROOT, "features", "fixtures"))
end

When /^I include the "([^"]*)" directory$/ do |path|
  @file_template.include_dir(File.join(PROJECT_ROOT, "features", "fixtures", path))
end

Then /^my file template should have Identifier "([^"]*)"$/ do |identifier|
  @file_template.identifier.should == identifier
end

Then /^my file template should have Kind "([^"]*)"$/ do |kind|
  @file_template.kind.should == kind
end

Then /^my file template should have the following file definitions:$/ do |table|
  @file_template.file_definitions.size.should == table.hashes.size
  table.hashes.each_with_index do |file_definition_expected, index|
    file_definition_actual = @file_template.file_definitions[index]
    file_definition_actual.input_path.should == file_definition_expected["input_path"]
    file_definition_actual.group_path.should == file_definition_expected["group_path"]
    file_definition_actual.output_path.should == file_definition_expected["output_path"]
    if file_definition_expected["include_in_target?"] == "true"
      file_definition_actual.include_in_target?.should == true
    else
      file_definition_actual.include_in_target?.should == false
    end
  end
end

Given /^I am using the test empty templates$/ do
  EmptyTemplate.empty_template_dir = File.join(PROJECT_ROOT, "features", "fixtures", "empty_templates")
end

When /^I export the file template to xml$/ do
  @xml = FileTemplateExporter.new(@file_template).to_xml
end

Then /^the xml should include "([^"]*)"$/ do |text|
  @xml.should include(text)
end