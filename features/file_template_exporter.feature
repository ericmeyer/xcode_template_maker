Feature: File template exporter

  Background:
    Given I am using the test empty templates
    Given I am creating a file template for "com.bob.MyFirstApp"
    And I include the "hello" directory

  Scenario: To XML includes the identifier
    When I export the file template to xml
    Then the xml should include "Identifier: com.bob.MyFirstApp"

  Scenario: To XML includes the file definitions
    When I export the file template to xml
    Then the xml should include "hello/world.h:hello/world.h"
    And the xml should include "hello/world.m:hello/world.m"


