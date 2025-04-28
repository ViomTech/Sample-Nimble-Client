#mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dcucumber.filter.tags=@Jeel -Dplatform=web -Dplatform.name=chrome -Durl=https://www.jeel.net/en/

Feature: Sample commands to Career Page
@Jeel
 Scenario: "Career Page Validation Test Case"
 And wait 5 secs
 And click "Join The Movement" with exact phrase