#mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dcucumber.filter.tags="@hdfc" -Dplatform=web -Dplatform.name=chrome -Durl=https://netbanking.hdfcbank.com/netbanking/

Feature: Sample commands
@hdfc
  Scenario: "Testing hdfc Web"
  And click "Accept" with exact phrase
  And scroll up until screen contains "Your personal details"
  And enter "Amit" into "First name" with exact phrase
	And enter "Gupta" into "Last name"
	And click "Title"
	And click "Mr"
	And read value from "First name" and save it as "firstName"
	And check that variable "firstName" is equals to "Amit"
	And wait 3 secs
	And go back
	And wait 3 secs
	And scroll up until screen contains "Connect with us"
	And click on the element contains desc as "The App Store download logo"
	And wait 2 secs
	And go back
	And wait 2 secs
	And relaunch the app
	And wait 2 secs
	And wait 10 secs
	