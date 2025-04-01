Feature: Sample commands
@mobiletc
  Scenario: Testing Mobile Settings app
  And wait 2 secs
  And click "Search settings"
  And wait 2 sec
  And enter "Network & internet"
  And click on the 2nd "Network & internet"
  And wait 2 sec
  And click "Internet"
  And wait 5 sec
  And click "Add network"
  And enter "new test" into "Enter the SSID"
  And click "Save"
  And click "Saved networks"