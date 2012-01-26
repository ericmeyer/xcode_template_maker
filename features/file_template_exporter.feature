Feature: File template exporter

  Background:
    Given I am creating a file template for "com.bob.MyFirstApp"
    And I include the "hello" directory
    When I export the file template to xml
  
  Scenario: To XML includes the identifier
    Then the xml should include "Identifier: com.bob.MyFirstApp"
