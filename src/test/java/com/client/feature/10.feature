#JAVA_HOME=/opt/homebrew/opt/openjdk@11 mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dcucumber.filter.tags="@tag1" -Dplatform=web -Dplatform.name=chrome -Dapp=singlife -Durl=https://demoqa.com/date-picker -DflaggedStepThreshold=300 -DflaggedStepMinOccurences=3
@tag1
Feature: Demo QA Feature Testing - Date-picker
  Scenario: Verify Select date - date-picker
    And click on the element with id as "datePickerMonthYearInput"
    And wait 2 sec
    And click on the element with class "react-datepicker__month-select"
    And wait 5 secs
    And print value of "todays-month-in-words"
#    And click on the 2nd "{todays-month-in-words}"
    And convert "{todays-month-in-words}" to camelcase and save as "my-month"
    And click on the 2nd "{my-month}"
    And wait 10 sec
    And click "January"
    And wait 10 secs
    And click on the element with class "react-datepicker__year-select"
    And wait 5 sec
    And click "2030"
    And wait 5 sec
    And click "30"

#  Scenario: Verify Date and Time - date-picker
#    And click on the element with id as "dateAndTimePickerInput"
#    And wait 2 sec
#    And click on the element with class "react-datepicker__month-read-view--down-arrow"
#    And wait 1 sec
#    And click "July"
#    And click on the element with class "react-datepicker__year-read-view"
#    And wait 1 sec
#    And click "2025"
#    And wait 2 sec
#    And click "30"
#    And wait 1 sec
#    And click "16:30"
