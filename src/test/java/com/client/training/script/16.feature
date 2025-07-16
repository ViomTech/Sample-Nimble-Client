#mvn clean test -Dcucumber.features=src/main/test -Dcucumber.filter.tags="@tag1" -Dplatform=web -Dplatform.name=chrome -Durl=https://demoqa.com/sortable

Feature: Demo QA Feature Testing - Sort
  Scenario: Verify Sort
    And click on the 1st "One" with class "list-group-item list-group-item-action"
    And drag "One" and drop it on "Five" with exact phrase
    And wait 5 sec
    And drag "One" and drop it on "Five" with exact phrase