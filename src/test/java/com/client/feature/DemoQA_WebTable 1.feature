Feature: Employee Management WebTable
  Scenario: Display employee data in a tabular format
    And check that screen contains following
      |First Name |
      |Last Name |
      |Age |
      |Email |
      |Salary |
      |Department |
      |Action |
      |Age |
    And check that screen contains following
      |Cierra|
      |Vega |

  Scenario: Add new employee
    And click "Add"
    And click "First Name" inside input
    And enter "Tester ABC"
    And click "Last Name" inside input
    And enter "Tester Last ABC"
    And click "name@example.com" inside input
    And enter "test@test.com"
    And click "Age" inside input
    And enter "34"
    And click "Salary" inside input
    And enter "10000"
    And click "Department" inside input
    And enter "QA"
    And click "Submit"
    And check that screen contains following
      |Tester ABC|
      |Tester Last ABC |
      |test@test.com |
      |34 |
      |10000 |
      |QA |

  Scenario: Edit employee information - Department
    And click "Edit"
    And click "Insurance" inside input
    And enter "NewDept"
    And click "Submit"
    And check that screen contains "NewDept"
    And wait 3 sec
    And check that screen does not contain "Insurance"

  Scenario: Delete employee
    And click "Delete"
    And wait 5 sec
    And check that screen does not contain "Cierra"
    And check that screen does not contain "NewDept"

  Scenario: Search employees
    And click "Type to search" inside input
    And enter "Alden"
    And check that screen contains following
      |Alden|
      |Cantrell |
    And check that screen does not contain following
      |Cierra|
      |Vega|
      |Kierra|
      |Gentry |