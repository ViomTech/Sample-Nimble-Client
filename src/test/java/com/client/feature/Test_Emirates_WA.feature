#mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dcucumber.filter.tags="@Emirates" -Dplatform=web -Dplatform.name=chrome -Durl=https://www.emirates.com/ae/english/

Feature: Sample commands
@Emirates
  Scenario: "Testing Etisalat Web"
  And wait 5 secs
  And click "Accept" with exact phrase
  And execute sub-routine "GoToLostPropertyMenu"
  And scroll up until screen contains "Your personal details"
  And enter "Amit" into "First name" with exact phrase
	And enter "Gupta" into "Last name"
	And click "Title"
	And click "Mr"
	And enter "amit@viom.tech" into "Email"
	And enter "amit@viom.tech" into "Confirm email"
	And click "Phone type"
	And click "Home" with exact phrase
	And click "Country code"
	And click "(+971)"
	And enter "569425400" into "Phone number"
	And click "Country of Residence" with exact phrase
	And click "United Arab Emirates" with exact phrase
	And scroll up until screen contains "Ticket details"
	And enter "1761231231231" into "Ticket number (Enter with no spaces)"
	And enter "15F" into "Seat number"
	And scroll up until screen contains "Lost item details"
	And click "Last seen at airport" with exact phrase
	And click "AMD"
	And click "Last seen in area" with exact phrase
	And click "Arrivals" with exact phrase
	And click "Last seen in location" with exact phrase
	And click "baggage hall"	
	And click "Item Category" with exact phrase
	And enter "Driving License" into "Item sub-category"
	And click "Cards / IDs"	
	And click "Colour" with exact phrase
	And click "Blue"
	And scroll up until screen contains "Add field (up to 6)"
	And wait 3 secs
	And click on the 1st "Submit" inside button with class "call-to-action__primary"
	And scroll up until screen contains "Select the flight"
	And wait 3 secs 
	And check that screen contains "Select the flight"	
#	And read value from "First name" and save it as "firstName"
#	And check that variable "firstName" is equals to "Amit"
#	And wait 5 secs
#	And go back
#	And wait 3 secs
#	And scroll up until screen contains "Connect with us"
#	And click on the element contains desc as "The App Store download logo"
#	And wait 2 secs
#	And go back
#	And wait 2 secs
#	And relaunch the app
#	And wait 2 secs
	And wait 10 secs
	