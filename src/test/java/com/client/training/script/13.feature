#mvn clean test -Dcucumber.features=src/main/test -Dcucumber.filter.tags="@tag1" -Dplatform=web -Dplatform.name=chrome -Durl=https://demoqa.com/slider
Feature: Demo QA Feature Testing - Slider
  Scenario: Verify slider
    And check that screen contains "25"
    And slide the "range-slider range-slider--primary" by 55 points to the right
    And wait 2 sec

