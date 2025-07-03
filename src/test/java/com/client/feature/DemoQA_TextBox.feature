#@demoQA-Textboxes
Feature: Demo QA Feature Testing
  Scenario: Enter Full Name
    Given check that screen contains "Full Name" with exact phrase
    When click on the 2nd "Full Name"
    And enter "John Dcosta"
    And check that screen contains "name@example.com"
    And click "name@example.com"
    And enter "john@gmail.com"
    And click on the 2nd "Current Address"
    And enter "Street 14/4, greford street, New Delhi"
    And scroll down until screen contains "Permanent Address" with exact phrase
    And click on the element with id as "permanentAddress"
    And enter "Same as current adreess"
    And click "Submit"