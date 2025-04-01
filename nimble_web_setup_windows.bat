@echo off
setlocal EnableDelayedExpansion

echo Starting Playwright Java environment setup for Windows...
echo Checking and installing required tools...

:: Set variables
set JAVA_VERSION=11
set MAVEN_VERSION=3.9.6
set CHOCO_URL=https://chocolatey.org/install.ps1
set JAVA_URL=https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_windows-x64_bin.zip
set MAVEN_URL=https://dlcdn.apache.org/maven/maven-3/%MAVEN_VERSION%/binaries/apache-maven-%MAVEN_VERSION%-bin.zip
set TEMP_DIR=%TEMP%\playwright_setup
set JAVA_DIR=C:\Java\jdk-11
set MAVEN_DIR=C:\Maven\apache-maven-%MAVEN_VERSION%

:: Create temp directory if it doesn’t exist
if not exist "%TEMP_DIR%" mkdir "%TEMP_DIR%"

:: -----------------------------------
:: 1. Check and Install Chocolatey (for easier installs)
:: -----------------------------------
echo Checking for Chocolatey...
choco --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Chocolatey not found. Installing Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('%CHOCO_URL%'))"
    if %ERRORLEVEL% NEQ 0 (
        echo Failed to install Chocolatey. Please install it manually from https://chocolatey.org/install.
        exit /b 1
    )
    echo Chocolatey installed successfully.
    call refreshenv
) else (
    echo Chocolatey is already installed.
)

:: -----------------------------------
:: 2. Check and Install JDK 11
:: -----------------------------------
echo Checking for Java JDK %JAVA_VERSION%...
java -version 2>&1 | findstr /C:"version \"%JAVA_VERSION%." >nul
if %ERRORLEVEL% NEQ 0 (
    echo Java JDK %JAVA_VERSION% not found. Installing via Chocolatey...
    choco install -y openjdk --version=11.0.20
    if %ERRORLEVEL% NEQ 0 (
        echo Chocolatey installation failed. Attempting manual download...
        powershell -Command "Invoke-WebRequest -Uri '%JAVA_URL%' -OutFile '%TEMP_DIR%\jdk11.zip'"
        powershell -Command "Expand-Archive -Path '%TEMP_DIR%\jdk11.zip' -DestinationPath '%JAVA_DIR%' -Force"
        if %ERRORLEVEL% NEQ 0 (
            echo Failed to install JDK. Please download and install JDK 11 manually from https://adoptium.net/.
            exit /b 1
        )
        echo JDK 11 installed to %JAVA_DIR%.
    ) else (
        echo JDK 11 installed via Chocolatey.
    )
    setx JAVA_HOME "%JAVA_DIR%" /M
    setx PATH "%PATH%;%JAVA_DIR%\bin" /M
    echo JAVA_HOME and PATH updated. You may need to restart your terminal.
) else (
    echo Java JDK %JAVA_VERSION% is already installed.
)

:: -----------------------------------
:: 3. Check and Install Maven
:: -----------------------------------
echo Checking for Maven...
mvn --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Maven not found. Installing Maven %MAVEN_VERSION%...
    powershell -Command "Invoke-WebRequest -Uri '%MAVEN_URL%' -OutFile '%TEMP_DIR%\maven.zip'"
    powershell -Command "Expand-Archive -Path '%TEMP_DIR%\maven.zip' -DestinationPath 'C:\Maven' -Force"
    if %ERRORLEVEL% NEQ 0 (
        echo Failed to install Maven. Please download and install Maven %MAVEN_VERSION% manually from https://maven.apache.org/download.cgi.
        exit /b 1
    )
    echo Maven installed to %MAVEN_DIR%.
    setx PATH "%PATH%;%MAVEN_DIR%\bin" /M
    echo PATH updated for Maven. You may need to restart your terminal.
) else (
    echo Maven is already installed.
)

:: -----------------------------------
:: 4. Create a Sample Playwright Project and Install Browsers
:: -----------------------------------
echo Setting up a sample Playwright Java project and ensuring browser binaries...
if not exist "playwright-test" (
    mkdir playwright-test
    cd playwright-test
    
    :: Create pom.xml
    echo ^<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^> > pom.xml
    echo   ^<modelVersion^>4.0.0^</modelVersion^> >> pom.xml
    echo   ^<groupId^>com.example^</groupId^> >> pom.xml
    echo   ^<artifactId^>playwright-test^</artifactId^> >> pom.xml
    echo   ^<version^>1.0-SNAPSHOT^</version^> >> pom.xml
    echo   ^<dependencies^> >> pom.xml
    echo     ^<dependency^> >> pom.xml
    echo       ^<groupId^>com.microsoft.playwright^</groupId^> >> pom.xml
    echo       ^<artifactId^>playwright^</artifactId^> >> pom.xml
    echo       ^<version^>1.47.0^</version^> >> pom.xml
    echo     ^</dependency^> >> pom.xml
    echo   ^</dependencies^> >> pom.xml
    echo ^</project^> >> pom.xml
    
    :: Create a browser installer Java file
    mkdir src\main\java\com\example
    echo package com.example; > src\main\java\com\example\InstallBrowsers.java
    echo import com.microsoft.playwright.*; >> src\main\java\com\example\InstallBrowsers.java
    echo public class InstallBrowsers { >> src\main\java\com\example\InstallBrowsers.java
    echo     public static void main(String[] args) { >> src\main\java\com\example\InstallBrowsers.java
    echo         try (Playwright playwright = Playwright.create()) { >> src\main\java\com\example\InstallBrowsers.java
    echo             playwright.chromium().launch().close(); >> src\main\java\com\example\InstallBrowsers.java
    echo             playwright.firefox().launch().close(); >> src\main\java\com\example\InstallBrowsers.java
    echo             playwright.webkit().launch().close(); >> src\main\java\com\example\InstallBrowsers.java
    echo             System.out.println("Browser binaries installed successfully."); >> src\main\java\com\example\InstallBrowsers.java
    echo         } >> src\main\java\com\example\InstallBrowsers.java
    echo     } >> src\main\java\com\example\InstallBrowsers.java
    echo } >> src\main\java\com\example\InstallBrowsers.java
    
    :: Create a sample test Java file
    echo package com.example; > src\main\java\com\example\PlaywrightTest.java
    echo import com.microsoft.playwright.*; >> src\main\java\com\example\PlaywrightTest.java
    echo public class PlaywrightTest { >> src\main\java\com\example\PlaywrightTest.java
    echo     public static void main(String[] args) { >> src\main\java\com\example\PlaywrightTest.java
    echo         try (Playwright playwright = Playwright.create()) { >> src\main\java\com\example\PlaywrightTest.java
    echo             Browser browser = playwright.chromium().launch(); >> src\main\java\com\example\PlaywrightTest.java
    echo             Page page = browser.newPage(); >> src\main\java\com\example\PlaywrightTest.java
    echo             page.navigate("https://example.com"); >> src\main\java\com\example\PlaywrightTest.java
    echo             System.out.println(page.title()); >> src\main\java\com\example\PlaywrightTest.java
    echo             browser.close(); >> src\main\java\com\example\PlaywrightTest.java
    echo         } >> src\main\java\com\example\PlaywrightTest.java
    echo     } >> src\main\java\com\example\PlaywrightTest.java
    echo } >> src\main\java\com\example\PlaywrightTest.java
    
    :: Resolve dependencies and download Playwright
    mvn dependency:resolve
    if %ERRORLEVEL% NEQ 0 (
        echo Failed to resolve Playwright dependencies. Check Maven installation and internet connection.
        exit /b 1
    )
    
    :: Install browser binaries
    mvn compile exec:java -Dexec.mainClass="com.example.InstallBrowsers"
    if %ERRORLEVEL% NEQ 0 (
        echo Failed to install Playwright browser binaries. Check Java and Maven setup.
        exit /b 1
    )
    echo Sample Playwright project created and browser binaries (Chromium, Firefox, WebKit) installed.
) else (
    echo Playwright project directory already exists. Skipping creation.
)

:: -----------------------------------
:: 5. Verify Setup
:: -----------------------------------
echo Verifying installed tools...
java -version
if %ERRORLEVEL% NEQ 0 (
    echo Java verification failed. Check installation.
) else (
    echo Java verified.
)
mvn --version
if %ERRORLEVEL% NEQ 0 (
    echo Maven verification failed. Check installation.
) else (
    echo Maven verified.
)

:: -----------------------------------
:: Cleanup and Final Instructions
:: -----------------------------------
echo Cleaning up temporary files...
rd /s /q "%TEMP_DIR%"

echo Setup complete! To run the sample Playwright script:
echo 1. cd playwright-test
echo 2. mvn compile exec:java -Dexec.mainClass="com.example.PlaywrightTest"
echo Note: Restart your terminal or computer if environment variables (JAVA_HOME, PATH) don’t work immediately.
pause