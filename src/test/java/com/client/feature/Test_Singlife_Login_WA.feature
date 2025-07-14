#JAVA_HOME=/opt/homebrew/opt/openjdk@11 mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dcucumber.filter.tags="@unhappy-login" -Dplatform=web -Dplatform.name=chrome -Dapp=singlife -Durl=https://singlife.com/en -DflaggedStepThreshold=300 -DflaggedStepMinOccurences=3
@unhappy-login
  Feature: login feature
    Scenario: Unhappy login scenario
      When hover over "Login"
      And click "MYSINGLIFE"
      And wait 8 sec
      And switch to last opened tab
      And wait for "Hello there"
      And wait for "Log in with email"
      And click "Log in with email"
      And wait 2 sec
      And click on the element with id as "input28"
      And enter "Test123"
      And click on the element with id as "input36"
      And enter "Test123"
      And click "Sign in"
      And wait 2 sec
      And check that screen contains "Incorrect username or password."
      And check that screen contains "Please try again!"
      And click "Help"
      And wait 2 sec
      And switch to last opened tab
      And click "I can’t login to MySinglife portal using Singpass. What should I do?"
      And wait 2 sec
      And click on the 1st "here" inside a with exact phrase
      And wait 5 sec
      And scroll down until screen contains "Your feedback matters" with exact phrase
      And click "Lodge a complaint"
      And wait 5 sec
      And wait for "Salutation" with exact phrase
      And scroll down until screen contains "Salutation" with exact phrase
      And click "Please select..." with exact phrase
      And click "Mr"
      And click on the element with id as "firstName"
      And enter "firstName"
      And click on the element with id as "surname"
      And enter "surname"
      And click on the element with id as "email"
      And enter "email@test.com"
      And click on the element with id as "phoneNumber"
      And enter "98765432"
      And click on the element with id as "nationalIdentifier"
      And enter "121"
      And click "I have read and agree to the terms and conditions above. "
      And click "Submit"
      And check that screen contains "We're sorry our service standard has fallen short of your expectations, or members of our team have not handled your concerns to your satisfaction."
      And wait 5 secs