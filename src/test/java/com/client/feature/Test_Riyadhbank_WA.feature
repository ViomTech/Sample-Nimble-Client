#mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dcucumber.filter.tags=@Jeel_Iban_Generate -Dplatform=web -Dplatform.name=chrome -Durl=https://www.riyadbank.com/en/personal-banking/info-tools/iban-generator
Feature: "Generate Iban Positive Test Case"
@GenerateIBAN
Scenario: "IBAN Validation"
  And scroll up until screen contains "Generate IBAN"
  And wait 2 secs
  And click "Generate IBAN"
  And wait 2 secs
  And click "saudi-banks" inside input with class "saudiBankRB"
  And wait 2 secs
  And click "e.g. 123456789" inside input with class "ibanAccountNumber"
  And enter "0000608010167519"
  And wait 5 secs