#mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dcucumber.filter.tags="@NetsContactUs" -Dplatform=web -Dplatform.name=chrome -Dapp=nets-for-you -Durl=https://www.nets.com.sg/nets/for-you -DflaggedStepThreshold=300 -DflaggedStepMinOccurences=3
@NetsContactUs
Feature: Contact Us Feature Testing
  Scenario: "Land to contact Us Page"
    When scroll up until screen contains "Contact Us"
    And click "Contact Us"
    And wait 3 secs
    And click "Send us an enquiry" inside button with class "kt-blocks-accordion-header"

  Scenario: Validate submission failure, if no data is provided
    When scroll up until screen contains "Submit"
    And click "Submit"
    And check that screen contains "This is a required field."

  Scenario: Validate if only Firstname is provided, then submission fails.
    And click on the element with id as "nf-field-505"
    And enter "John"
    And press enter
    And check that screen contains "This is a required field."

  Scenario: Validate after phone is provided, then submission fails.
    And click "phone" inside input
    And enter "81337620"
    And press enter
    And check that screen contains "This is a required field."

  Scenario: Validate after email is provide, then also submission fails
    And click "email" inside input
    And enter "john@gmail.com"
    And press enter
    And check that screen contains "This is a required field."

  Scenario: Validate after subject is provided, then also submission fails
    And click on the element with id as "nf-field-512"
    And enter "Facing issues with eNets service"
    And press enter
    And check that screen contains "This is a required field."
    And wait 5 secs