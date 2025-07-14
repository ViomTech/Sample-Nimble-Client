Feature: Demo QA Feature Testing -  Menu
  Scenario: Verify Menu and Sub Menu
    And check that screen contains following
    | Main Item 1 |
    | Main Item 2 |
    | Main Item 3 |
    And hover over "Main Item 2" with exact phrase
    And wait 2 sec
    And check that screen contains following
      | Sub Item |
      | SUB SUB LIST » |
    And wait 2 sec
    And hover over "SUB SUB LIST »" with exact phrase
    And wait 2 sec
    And check that screen contains following
      | Sub Sub Item 1 |
      | Sub Sub Item 2 |