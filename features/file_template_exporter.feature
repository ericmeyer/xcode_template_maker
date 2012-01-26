Feature: File template exporter

  Background:
    Given I am creating a file template for "com.bob.MyFirstApp"
    And I include the "hello" directory
  
  Scenario: To XML includes the identifier
    When my file template has the form "Identifier: {{IDENTIFIER}}"
    And I export the file template to xml
    Then the xml should include "Identifier: com.bob.MyFirstApp"
