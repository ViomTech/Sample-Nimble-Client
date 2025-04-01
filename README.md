# 

# 🚀 Test Automation Framework

## 📌 Table of Contents
- [📋 Prerequisites](#prerequisites)
- [🔧 Project Setup](#project-setup)
- [🚀 Running Tests](#running-tests)
- [⚙️ Configurations](#configurations)
- [📊 Reports](#reports)
- [❓ Troubleshooting](#troubleshooting)
- [📜 License](#license)

---

## 📋 Prerequisites

Before setting up the project, ensure you have the following installed:
- **Java** (Version: `11.0.0` or later) ➜ [Download Java](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)
- **Maven** (Version: `3.x`) ➜ [Download Maven](https://maven.apache.org/download.cgi)
- **Node.js** [Download Node.js](https://nodejs.org/)

To check installations, run:
```sh
java -version
mvn -version
node -v # (if required)
```

---

## 🔧 Project Setup
###Clone the repository and install dependencies:
```sh
git clone <GIT_REPOSITORY_URL>
cd <PROJECT_NAME>
mvn clean install
```
###Install Playwright:
```sh
npx playwright install
```
###Install the VS2015 runtime (Only for Windows)
```sh
https://www.microsoft.com/en-in/download/details.aspx?id=48145
```
---

## 🚀 Running Tests
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





