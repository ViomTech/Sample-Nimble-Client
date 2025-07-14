Feature: Demo QA Feature Testing - AutoComplete

  Scenario: Ensure Visibility of UI Elements
    And check that screen contains "Type multiple color names"
    And check that screen contains "Type single color name"

  Scenario: Fill Autocomplete - single result
    And click on the element with id as "autoCompleteSingleInput"
    And enter "Re"
    And click "Red"
    And wait 3 sec
    And check that screen contains "Red"

  Scenario: Fill Autocomplete - multiple result
    And click on the element with id as "autoCompleteMultipleInput"
    And enter "B"
    And check that screen contains "Black"
    And check that screen contains "Blue"
    And click "Blue"
    And wait 2 sec
    And check that screen does not contain "Black"
