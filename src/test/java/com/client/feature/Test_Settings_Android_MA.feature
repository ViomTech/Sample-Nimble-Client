#JAVA_HOME=/opt/homebrew/opt/openjdk@11 mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dcucumber.filter.tags=@mobiletc -Dplatform=mobile -Dplatform.name=android -Dplatform.version=16.0 -Ddevice.name=emulator-5554 -Dapp=android-settings -Dapp.package="com.android.settings" -Dapp.activity="com.android.settings.Settings" -DflaggedStepThreshold=300 -DflaggedStepMinOccurences=3
#JAVA_HOME=/opt/homebrew/opt/openjdk@11	mvn clean test -Dcucumber.features=src/test/java/com/nimble/feature -Dcucumber.filter.tags=@mobiletc -Dplatform=mobile -Dplatform.name=android -Dapp.name=AndroidSettings -Dflagged.step.threshold=500 -Dflagged.step.min.occurrences=3 -Dplatform.version=16.0 -Ddevice.name=emulator-5554 -Dautomation.name=UiAutomator2 -Dapp.package="com.android.settings" -Dapp.activity="com.android.settings.Settings" -DargLine=-Xmx1024m
Feature: Sample commands
@mobiletc
  Scenario: Testing Mobile Settings app
  And wait 5 secs
  And click "Search Settings"
  And wait 5 sec
  And enter "Network & internet"
  And wait 5 sec
  And click on the 2nd "Network & internet"
  And wait 5 sec
  And click "Internet"
  And wait 5 sec
  And click "Add network"
  And wait 5 sec
  And enter "new test" into "Enter the SSID"
  And wait 5 sec
  And click "Save"
  And wait 5 sec
  And click "Saved networks"