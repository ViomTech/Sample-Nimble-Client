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
  And click "Choose a Bank"
  And click "ARAB NATIONAL BANK"
  And wait 2 secs
  And click on the element with id as "_com_rb_iban_generator_web_RbIbanGeneratorWebPortlet_INSTANCE_kojb_ibangeneratesbmt"
  And wait 5 secs
  And check that screen contains "Your iBAN is: SA6730000000608010167519"
  And wait 5 secs
  And read value from "Your iBAN is: SA6730000000608010167519" and save it as "iban"
#  Then check that variable "IbanAccountNumber" is equals to "SA6730000000608010167519"
  Then check that variable "iban" contains "SA67300000006080101675191"