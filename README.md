# 

# 🚀 Test Automation Framework

## 📌 Table of Contents
- [📋 Prerequisites](#-prerequisites)
- [🔧 Project Setup](#-project-setup)
- [🚀 Running Tests](#-running-tests)
- [⚙️ Configurations](#-configurations)
- [📊 Reports](#-reports)
- [❓ Troubleshooting](#-troubleshooting)
- [📜 License](#-license)

---

## 📋 Prerequisites

As step-1, first download or clone the Sample-Nimble-Client Project from the git repository https://github.com/ViomTech/Sample-Nimble-Client.

To install the pre-requisites of **Nimble-W / Nimble-M / Nimble-Cross**, follow the below steps -
- **MAC/Linux/Unix OS** 
  - **Nimble-Cross / Nimble-M:** Run nimble_mobile_setup_mac.sh script, located in the root folder of Sample-Nimble-Client Project.
  - **Nimble-Cross / Nimble-W:** Run nimble_web_setup_mac.sh script, located in the root folder of Sample-Nimble-Client Project. (Nimble-W)
- **Windows OS** 
  - Run nimble_mobile_setup_windows.bat script, located in the root folder of Sample-Nimble-Client Project.

Follow the instructions on the screen for successfull installations and verification of the installations.
```sh
java -version
mvn -version
node -v # (if required)
```

---

## 🔧 Project Setup

- Download the Nimble from www.viom.tech. 
- The artifact will be in .zip format, unzip it.
- Run the below command to install the nimble in .M2 folder of the machine.
- Make sure 
  - the location and name of the jar file in -Dfile argument is correct
  - -Dversion is correct
```sh

mvn install:install-file \
  -Dfile=/Users/amitgupta/Viom/Products/Sample-Nimble-Client/libs/tech/viom/nimble/1.0.0/nimble-1.0.0.jar \
  -DgroupId=tech.viom \
  -DartifactId=nimble \
  -Dversion=1.0.0 \
  -Dpackaging=jar

```

---

## 🚀 Running Feature files in Sample-Nimble-Client
### ✅ Run all tests for a web app and on specific browser and a specific tag
```sh
mvn clean test -Dcucumber.features=src/test/java/com/client/feature  -Dplatform=web -Dplatform.name=chrome -Durl=https://www.emirates.com/ae/english/

OR

mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dcucumber.filter.tags="@RunFirst or @Emirates" -Dplatform=web -Dplatform.name=chrome
```
### 🔹 Run tests with specific tag on specific browser
```sh
mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dcucumber.filter.tags="@Try" -Dplatform=web -Dplatform.name=edge

OR

mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dcucumber.filter.tags="@RunFirst or @Emirates" -Dplatform=web -Dplatform.name=edge

```
### 🎯 Run a specific feature file of a webapp on a specific browser
```sh
mvn test -Dcucumber.features="src/test/resources/features/<feature_file>.feature" -Dplatform=web -Dplatform.name=firefox

OR

mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dcucumber.filter.tags="@RunFirst or @Emirates" -Dplatform=web -Dplatform.name=firefox

```
### 🎯 Run a specific feature file of a android app
```sh
mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dplatform=mobile -Dplatform.name=android -Dplatform.version=14 -Dcucumber.filter.tags="@TryMobile"
```
### 🎯 Run a specific feature file of a iOS app
```sh
mvn clean test -Dcucumber.features=src/test/java/com/client/feature -Dplatform=mobile -Dplatform.name=ios -Dplatform.version=14 -Dcucumber.filter.tags="@AHB" 
```
---

## ⚙️ Configurations
Environment specific configurations should managed in environment specific property files as shown below. 

| Environment  | Description |
|-----------|-------------|
| `DEV` | config-dev.properties |
| `QA`     | config-qa.properties |
| `SIT`| config-sit.properties |


---

## 📊 Reports
After execution, test reports can be found in:
```sh
target/cucumber-reports/
```
To open an HTML report:
```sh
open target/cucumber-reports/index.html
```

---

## ❓ Troubleshooting
### ❌ Maven Build Failure
Check dependencies and try:

```sh
mvn clean install -U
```
### ❌ Playwright Browser Issues
Ensure browsers are installed:

```sh
npx playwright install
```
---

## 📜 License
This project is licensed under the Viom Technology Services(LICENSE).

---

💡 **Need Help?** Feel free to raise an issue on nimble@viom.tech !





