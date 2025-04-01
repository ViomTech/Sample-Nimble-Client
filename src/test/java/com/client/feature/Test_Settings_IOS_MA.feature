Feature: Sample commands
@mobiletcios
  Scenario: Testing Mobile Settings app
  And wait 2 secs
  And click "General"
  And click "Keyboard"
  And click "Text Replacement"
  And wait 2 sec
  And click "Add"
  And click "Phrase"
  And enter "Test nimble" into "Phrase"
  And enter "Hello" into "Shortcut"
  And click "Save"
  And wait 2 sec
  And click "Search"
  And enter "Test nimble"