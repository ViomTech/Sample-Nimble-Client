#mvn clean test -Dcucumber.features=src/main/test -Dcucumber.filter.tags="@tag1" -Dplatform=web -Dplatform.name=chrome -Durl=https://demoqa.com/checkbox
Feature: Demo QA Feature Testing - Radio

  Scenario: Select Yes option
    And check that screen contains "Do you like the site?"
    And check that screen contains following
      | Yes |
      | Impressive  |
      | No   |
    And check that radio button "Yes" is not selected
    And check that radio button "Impressive" is not selected
    And check that radio button "No" is not selected
    And click "Yes"
    And check that radio button "Yes" is selected
    And check that screen contains "You have selected Yes"
    And check that radio button "Impressive" is not selected
    And check that radio button "No" is not selected

  Scenario: Select Impressive option
    And click "Impressive"
    And check that radio button "Impressive" is selected
    And check that screen contains "You have selected Impressive"
    And check that radio button "Yes" is not selected
    And check that radio button "No" is not selected

  Scenario: Select No option
    And click "No"
    And check that button "No" is disabled
