#mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dcucumber.filter.tags=@Webshop -Dplatform=web -Dplatform.name=chrome -Durl=https://demowebshop.tricentis.com/

Feature: Sample commands
@Webshop
  Scenario: "Testing Demo shop login"
  And wait 5 secs
  And click "Log in" with exact phrase
  And wait 3 secs
  And enter "lazyredpanda@gmail.com" into "Email"
  And wait 1 secs
  And enter "lazyredpanda" into "Password"
  And wait 1 secs
  And click "Log in" inside input with class "login-button"
  And wait 2 secs
