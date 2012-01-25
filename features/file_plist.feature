Feature: File Template
  In order to remove duplication in my Xcode templates
  As a developer
  I want a separate template for just the files
  
  Scenario: One nonempty directory with no subdirectories
    Given I am creating a file template for "com.bob.MyFirstApp"
    When I include the "hello" directory
    Then my file template should have Identifier "com.bob.MyFirstApp"
    And my file template should have Kind "Xcode.Xcode3.ProjectTemplateUnitKind"
    And my file template should have the following file definitions:
     | input_path              | group_path | output_path             | include_in_target? |
     | hello/different_world.c | hello      | hello/different_world.c | true               |
     | hello/different_world.h | hello      | hello/different_world.h | false              |
     | hello/world.h           | hello      | hello/world.h           | false              |
     | hello/world.m           | hello      | hello/world.m           | true               |
    # And my file template should have a target
