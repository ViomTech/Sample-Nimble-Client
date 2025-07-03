@tag12
Feature: Demo QA Feature Testing - Accordian

  Scenario: User can view details of one at a time
    And check that screen contains "What is Lorem Ipsum?"
    And click "What is Lorem Ipsum?"
    And check that screen contains "Aldus PageMaker including versions of Lorem Ipsum."
    And click "Where does it come from?"
    And check that screen does not contain "Aldus PageMaker including versions of Lorem Ipsum."
    And check that screen contains "Contrary to popular belief"
    And click "Why do we use it?"
    And check that screen contains "injected humour and the like"
    And check that screen does not contain "Aldus PageMaker including versions of Lorem Ipsum."
    And check that screen does not contain "Contrary to popular belief"
    And click "Why do we use it?"
    And wait 2 sec
    And check that screen does not contain "injected humour and the like"
    And check that screen does not contain "Aldus PageMaker including versions of Lorem Ipsum."
    And check that screen does not contain "Contrary to popular belief"
