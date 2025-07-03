#JAVA_HOME=/opt/homebrew/opt/openjdk@11;mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dcucumber.filter.tags="@AutomationPracticeForm" -Dplatform=web -Dplatform.name=chrome -Dapp=automation-practice-form -Durl=https://demoqa.com/automation-practice-form -DflaggedStepThreshold=500 -DflaggedStepMinOccurences=3
@AutomationPracticeForm
Feature: Contact Us Feature Testing
  Scenario: TestAutomationFormSubmission
    When enter "John" into "First Name"
    Then enter "Wick" into "Last Name"
    Then enter "john.wick@gmail.com" into "name@example.com"
    Then click "Male"
    Then enter "8798387983" into "Mobile Number"
    Then go to next element
    And enter "22 Jan 1980"
    And press enter
    Then click on the element with class "subjects-auto-complete__value-container"
    Then enter "Maths, Science, English"
    And scroll up until screen contains "Reading" with exact phrase
    Then click "Reading"
    Then enter "Sector 76 Noida" into the 2nd "Current Address"
    Then click "Select State"
    And wait 5 secs
    Then click "NCR"
    Then click "Select City"
    Then click "Noida"
    Then click "Submit"


