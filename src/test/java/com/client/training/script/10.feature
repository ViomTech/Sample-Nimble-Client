#mvn clean test -Dcucumber.features=src/main/test -Dcucumber.filter.tags="@tag1" -Dplatform=web -Dplatform.name=chrome -Durl=https://demoqa.com/date-picker
Feature: Demo QA Feature Testing - Date-picker
  Scenario: Verify Select date - date-picker
    And click on the element with id as "datePickerMonthYearInput"
    And read value from "{todays-month-in-words}" and save it as "month"
    And read value from "{todays-year}" and save it as "year"
    And click "{month}"
    And wait 1 sec
    And click "January"
    And click "{year}"
    And wait 1 sec
    And click "2030"
    And wait 1 sec
    And click "2"

  Scenario: Verify Date and Time - date-picker
    And click on the element with id as "dateAndTimePickerInput"
    And read value from "{todays-month-in-words}" and save it as "month"
    And read value from "{todays-year}" and save it as "year"
    And click on the 2nd "{month}"
    And wait 1 sec
    And click "January"
    And click on the 2nd "{year}"
    And wait 1 sec
    And click "2030"
    And wait 1 sec
    And click "2"
    And wait 1 sec
    And click "4:30"
