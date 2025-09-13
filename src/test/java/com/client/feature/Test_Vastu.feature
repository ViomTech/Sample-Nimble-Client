#mvn clean test -Dcucumber.features=src/test/java/feature -Dcucumber.filter.tags="@vastu" -Dplatform=web -Dplatform.name=chrome -Dapp=vastu -Durl=https://test-aws-web.vastucorp.com/login -DflaggedStepThreshold=300 -DflaggedStepMinOccurences=
@vastu
Feature: Vastu Scenarios

  Scenario: Login to Vastu web
    And check that screen contains "Login Here"
    And check that screen contains "Sign in With ZOHO"
    And enter "user_4650@vastuhfc.com" into "Email"
    And enter "123456" into "Password"
    And click "Login"