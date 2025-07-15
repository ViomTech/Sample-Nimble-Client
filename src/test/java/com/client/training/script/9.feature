#mvn clean test -Dcucumber.features=src/main/test -Dcucumber.filter.tags="@tag1" -Dplatform=web -Dplatform.name=chrome -Durl=https://demoqa.com/tool-tips
Feature: Demo QA Feature Testing - ToolTip
  Scenario: ToolTip is visible when hovered
    And check that screen does not contain "You hovered over the Button"
    And hover over the 2nd "Hover me to see" with exact phrase
    And wait 2 sec
    And check that screen contains "You hovered over the Button"
