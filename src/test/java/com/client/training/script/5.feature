@tag12
Feature: Demo QA Feature Testing - Checkbox
  Scenario: User can expand or collapse a folder
    And check that screen contains "Home"
    And click "Toggle"
    And check that screen contains following
      | Desktop |
      | Documents |
      | Downloads |
    And click "Toggle"
    And check that screen does not contain following
      | Desktop |
      | Documents |
      | Downloads |

  Scenario: User can expand all folders
    And click on the 1st "Expand all"
    And check that screen contains following
      | Desktop |
      | Commands |
      | Downloads |
      | Workspace |
      | Excel File.doc |
      | Workspace |

  Scenario: User can collapse all folders
    And click on the 1st "Collapse all"
    And check that screen does not contain following
      | Desktop |
      | Commands |
      | Downloads |
      | Workspace |
      | Excel File.doc |
      | Workspace |


  Scenario: User can select individual folders
    And click "Home"
    And check that checkbox "Home" is checked
    And check that screen contains "You have selected :"
    And check that screen contains "home"
    And click "Home"
    And check that checkbox "Home" is unchecked

