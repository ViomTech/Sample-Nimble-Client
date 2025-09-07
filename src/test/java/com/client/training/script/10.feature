#mvn clean test -Dcucumber.features=src/main/test -Dcucumber.filter.tags="@tag1" -Dplatform=web -Dplatform.name=chrome -Durl=https://demoqa.com/date-picker

Feature: Demo QA Feature Testing - Date-picker
  Scenario: Verify Select date - date-picker
    And click on the element with id as "datePickerMonthYearInput"
    And wait 2 sec
    And click on the element with class "react-datepicker__month-select"
    And print value of "todays-month-in-words"
    And click "todays-month-in-words"
    And wait 20 sec
    And click "January"
    And click on the element with class "react-datepicker__year-select"
    And wait 1 sec
    And click "2030"
    And wait 1 sec
    And click "30"

  Scenario: Verify Date and Time - date-picker
    And click on the element with id as "dateAndTimePickerInput"
    And wait 2 sec
    And click on the element with class "react-datepicker__month-read-view--down-arrow"
    And wait 1 sec
    And click "January"
    And click on the element with class "react-datepicker__year-read-view"
    And wait 1 sec
    And click "2030"
    And wait 2 sec
    And click "30"
    And wait 1 sec
    And click "16:30"
