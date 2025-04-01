Feature: Sample commands
#https://www.du.ae/personal
@Du
  Scenario: "Testing Web"
  When click "Login"
  Then click "Username or email"
  Then enter "agupta@alhilalbank.ae"
  #Then click "Password"
  #Then enter "Q1w2e3r4!"
  #Then wait 5 secs
  #And click on the 2nd "Login" 
  And wait 10 secs
	