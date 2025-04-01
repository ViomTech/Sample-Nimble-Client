@RunFirst @Emirates
Feature: Common Steps

  Scenario: Create sub-routine
    Given create sub-routine "GoToLostPropertyMenu" with the following steps:
    """
    When scroll up until screen contains "HELP"
    And click " HELP "
    And click "Lost property"
    """
