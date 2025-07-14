Feature: Demo QA Feature Testing -  Select Menu
  Scenario: Verify Select Menu
    And check that screen contains "Select Value"
    And click "Select Option"
    And wait 2 sec
    And click "Group 1, option 1"
    And check that screen contains "Select One"
    And click "Select Title"
    And wait 2 sec
    And click "Dr."
    And wait 2 sec
    And check that screen contains "Old Style Select Menu"
    And check that screen contains "Multiselect drop down"
    And click "Select..."
    And wait 2 sec
    And click "Black"
    And click "Green"
    And check that screen contains "Standard multi select"
    And wait 2 sec
    And check that screen contains following
    | Volvo |
    | Saab  |
    | Opel  |
    | Audi  |
    And click "Volvo"




