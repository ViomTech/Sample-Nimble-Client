#JAVA_HOME=/opt/homebrew/opt/openjdk@11;mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dcucumber.filter.tags="@DemoQA-Buttons" -Dplatform=web -Dplatform.name=chrome -Dapp=DemoQA-Button-Testing -Durl=https://demoqa.com/buttons -DflaggedStepThreshold=500 -DflaggedStepMinOccurences=3
@DemoQA-Buttons
Feature: Demo QA Feature Testing - Buttons
  Scenario: User double-clicks the "Double Click Me" button
    Given check that screen contains "Double Click Me"
    When double click "Double Click Me"
    And check that screen contains "You have done a double click"

  Scenario: User right-clicks the "Right Click Me" button
    Given check that screen contains "Right Click Me"
    When right click "Right Click Me"
    And check that screen contains "You have done a right click"

  Scenario: User clicks the "Click Me" button
    Given check that screen contains "Click Me"
    When click "Click Me" with exact phrase
    And check that screen contains "You have done a dynamic click"