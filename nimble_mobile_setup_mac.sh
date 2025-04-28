#!/bin/bash

echo "Starting Appium Java environment setup for macOS (iOS and Android simulators)..."
echo "Checking and installing required tools..."

# Set variables
JAVA_VERSION=11
NODE_VERSION=20
MAVEN_VERSION=3.9.6
APPIUM_VERSION=2.5.4
JAVA_URL="https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.20%2B8/OpenJDK11U-jdk_x64_mac_hotspot_11.0.20_8.tar.gz"
MAVEN_URL="https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"
TEMP_DIR="/tmp/appium_setup"
JAVA_DIR="/usr/local/java/jdk-11"
MAVEN_DIR="/usr/local/maven/apache-maven-${MAVEN_VERSION}"
SCRIPT_PATH="$(realpath "$0")"

# Ensure script is executable
echo "Checking script permissions..."
if [ ! -x "$SCRIPT_PATH" ]; then
    echo "Script is not executable. Making it executable..."
    chmod +x "$SCRIPT_PATH"
    if [ $? -ne 0 ]; then
        echo "Failed to make script executable. Please run 'chmod +x $SCRIPT_PATH' manually and re-run."
        exit 1
    fi
    echo "Script permissions updated. For this run, execute again with './nimble_mobile_setup_mac.sh'."
fi

# Create temp directory
mkdir -p "$TEMP_DIR"

# 1. Check and Install Homebrew
echo "Checking for Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ $? -ne 0 ]; then
        echo "Failed to install Homebrew. Install manually from https://brew.sh."
        exit 1
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)" || eval "$(/usr/local/bin/brew shellenv)"
    echo "Homebrew installed."
else
    echo "Homebrew is already installed."
fi

# 🛠️ Ensure npm global bin path (Appium) is in PATH
echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# 2. Check and Install JDK 11
echo "Checking for Java JDK $JAVA_VERSION..."
if ! java -version 2>&1 | grep -q "version \"$JAVA_VERSION\."; then
    echo "Java JDK $JAVA_VERSION not found. Installing via Homebrew..."
    brew install openjdk@11
    if [ $? -ne 0 ]; then
        echo "Homebrew installation failed. Attempting manual download..."
        curl -L "$JAVA_URL" -o "$TEMP_DIR/jdk11.tar.gz"
        sudo mkdir -p "$JAVA_DIR"
        sudo tar -xzf "$TEMP_DIR/jdk11.tar.gz" -C "$JAVA_DIR" --strip-components=1
        if [ $? -ne 0 ]; then
            echo "Failed to install JDK. Install manually from https://adoptium.net/."
            exit 1
        fi
        echo "JDK 11 installed to $JAVA_DIR."
    else
        echo "JDK 11 installed via Homebrew."
        JAVA_DIR=$(brew --prefix openjdk@11)
    fi
    echo "export JAVA_HOME=$JAVA_DIR" >> ~/.zshrc
    echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.zshrc
    source ~/.zshrc
    echo "JAVA_HOME and PATH updated."
else
    echo "Java JDK $JAVA_VERSION is already installed."
fi

# 3. Check and Install Maven
echo "Checking for Maven..."
if ! mvn --version >/dev/null 2>&1; then
    echo "Maven not found. Installing Maven $MAVEN_VERSION via Homebrew..."
    brew install maven
    if [ $? -ne 0 ]; then
        echo "Homebrew installation failed. Attempting manual download..."
        curl -L "$MAVEN_URL" -o "$TEMP_DIR/maven.tar.gz"
        sudo mkdir -p "/usr/local/maven"
        sudo tar -xzf "$TEMP_DIR/maven.tar.gz" -C "/usr/local/maven"
        if [ $? -ne 0 ]; then
            echo "Failed to install Maven. Install manually from https://maven.apache.org/."
            exit 1
        fi
        echo "Maven installed to $MAVEN_DIR."
    else
        echo "Maven installed via Homebrew."
        MAVEN_DIR=$(brew --prefix maven)
    fi
    echo "export PATH=$MAVEN_DIR/bin:\$PATH" >> ~/.zshrc
    source ~/.zshrc
    echo "PATH updated for Maven."
else
    echo "Maven is already installed."
fi

# 4. Check and Install Node.js and npm
echo "Checking for Node.js and npm..."
if ! node --version >/dev/null 2>&1 || ! npm --version >/dev/null 2>&1; then
    echo "Node.js or npm not found. Installing Node.js $NODE_VERSION via Homebrew..."
    brew install node@20
    if [ $? -ne 0 ]; then
        echo "Failed to install Node.js. Install manually from https://nodejs.org/."
        exit 1
    fi
    echo "Node.js and npm installed."
    echo "export PATH=/opt/homebrew/opt/node@20/bin:\$PATH" >> ~/.zshrc
    source ~/.zshrc
else
    echo "Node.js and npm are already installed."
fi

# 5. Check and Install Appium
echo "Checking for Appium..."
if ! appium --version >/dev/null 2>&1; then
    echo "Appium not found. Installing Appium $APPIUM_VERSION..."
    npm install -g appium@$APPIUM_VERSION
    if [ $? -ne 0 ]; then
        echo "Failed to install Appium. Install manually with 'npm install -g appium'."
        exit 1
    fi
    echo "Appium installed."
else
    echo "Appium is already installed. Checking version..."
    INSTALLED_VERSION=$(appium --version)
    if [ "$INSTALLED_VERSION" != "$APPIUM_VERSION" ]; then
        echo "Installed Appium version ($INSTALLED_VERSION) does not match required version ($APPIUM_VERSION). Updating..."
        npm uninstall -g appium
        npm install -g appium@$APPIUM_VERSION
        if [ $? -ne 0 ]; then
            echo "Failed to update Appium. Install manually with 'npm install -g appium@$APPIUM_VERSION'."
            exit 1
        fi
        echo "Appium updated to $APPIUM_VERSION."
    else
        echo "Appium $APPIUM_VERSION is already installed."
    fi
fi

# 6. Install or Update Appium Drivers
echo "Checking and installing/updating Appium drivers for iOS and Android..."

# Function to check if a driver is installed using awk
#check_driver_installed() {
#    local driver_name="$1"
#    # Use awk to match lines with "- <driver_name>@" and return 0 if found, 1 if not
#    appium driver list --installed | awk '/- '"$driver_name"'@/ {found=1; exit 0} END {if (!found) exit 1}'
#    return $?
#}
# Helper function to check installed drivers using JSON output
check_driver_installed() {
    local driver_name="$1"
    appium driver list --installed --json | grep -q ""$driver_name""
}

# Install or update XCUITest driver
echo "Checking XCUITest driver..."
if check_driver_installed "xcuitest"; then
    echo "XCUITest driver is already installed. Skipping install..."
    appium driver update xcuitest
    if [ $? -ne 0 ]; then
        echo "Failed to update XCUITest driver. Run 'appium driver update xcuitest' manually."
        exit 1
    fi
    echo "XCUITest driver updated."
else
    echo "XCUITest driver not found. Installing..."
    appium driver install xcuitest
    if [ $? -ne 0 ]; then
        echo "Failed to install XCUITest driver. Run 'appium driver install xcuitest' manually."
        exit 1
    fi
    echo "XCUITest driver installed."
fi

# Install or update UiAutomator2 driver
echo "Checking UiAutomator2 driver..."
if check_driver_installed "uiautomator2"; then
    echo "UiAutomator2 driver is already installed. Updating..."
    appium driver update uiautomator2
    if [ $? -ne 0 ]; then
        echo "Failed to update UiAutomator2 driver. Run 'appium driver update uiautomator2' manually."
        exit 1
    fi
    echo "UiAutomator2 driver updated."
else
    echo "UiAutomator2 driver not found. Installing..."
    appium driver install uiautomator2
    if [ $? -ne 0 ]; then
        echo "Failed to install UiAutomator2 driver. Run 'appium driver install uiautomator2' manually."
        exit 1
    fi
    echo "UiAutomator2 driver installed."
fi

# 7. Check and Install Xcode
echo "Checking for Xcode..."
XCODE_PATH="/Applications/Xcode.app/Contents/Developer"
if ! xcode-select -p >/dev/null 2>&1; then
    echo "Xcode command-line tools not found. Installing..."
    xcode-select --install
    if [ $? -ne 0 ]; then
        echo "Failed to install Xcode command-line tools. Install Xcode from App Store and run 'xcode-select --install' manually."
        exit 1
    fi
    echo "Xcode command-line tools installed."
else
    echo "Xcode command-line tools are already installed."
fi

# Check for full Xcode installation
if [ ! -d "$XCODE_PATH" ] || ! xcrun simctl list devices >/dev/null 2>&1; then
    echo "Full Xcode installation not detected or simulators unavailable."
    echo "The full Xcode IDE (including iOS simulators) is required for Appium iOS testing."
    echo "Please follow these steps:"
    echo "1. Open the App Store (or visit https://developer.apple.com/download/all/)."
    echo "2. Search for 'Xcode' and install the latest version (e.g., Xcode 15.x)."
    echo "3. After installation, open Xcode to complete setup (agree to terms, install additional components)."
    echo "4. Run 'xcode-select --switch /Applications/Xcode.app/Contents/Developer' to set the path."
    echo "Opening App Store now..."
    open -a "App Store" "macappstore://apps.apple.com/app/xcode/id497799835"

    # Wait for Xcode to be installed
    echo "Waiting for Xcode installation. Press Enter once Xcode is installed and opened at least once..."
    read -p "Press Enter to continue..."

    # Re-check after user input
    if [ ! -d "$XCODE_PATH" ] || ! xcrun simctl list devices >/dev/null 2>&1; then
        echo "Xcode still not fully installed or simulators unavailable. Please ensure Xcode is installed and run again."
        exit 1
    fi
    echo "Xcode installation verified."
else
    echo "Full Xcode installation detected with simulators available."
fi

# Ensure xcode-select points to the full Xcode path
if [ -d "$XCODE_PATH" ]; then
    sudo xcode-select --switch "$XCODE_PATH"
    echo "xcode-select path set to $XCODE_PATH."
fi

# 8. Check and Install Android Studio
echo "Checking for Android Studio and SDK..."
if ! command -v adb >/dev/null 2>&1; then
    echo "Android SDK not found. Installing Android Studio via Homebrew..."
    brew install --cask android-studio
    if [ $? -ne 0 ]; then
        echo "Failed to install Android Studio. Install manually from https://developer.android.com/studio."
        exit 1
    fi
    echo "Android Studio installed. Setting up ANDROID_HOME..."
    echo "export ANDROID_HOME=$HOME/Library/Android/sdk" >> ~/.zshrc
    echo "export PATH=\$ANDROID_HOME/emulator:\$ANDROID_HOME/platform-tools:\$PATH" >> ~/.zshrc
    source ~/.zshrc
    echo "ANDROID_HOME and PATH updated."
else
    echo "Android SDK is already installed."
fi

# Force export ANDROID_HOME again in current session
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH"
echo "ANDROID_HOME and PATH updated."



# 9. Create Sample Appium Project
echo "Setting up a sample Appium Java project..."
if [ ! -d "appium-test" ]; then
    mkdir appium-test
    cd appium-test
    
    # Create pom.xml
    cat <<EOL > pom.xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.example</groupId>
  <artifactId>appium-test</artifactId>
  <version>1.0-SNAPSHOT</version>
  <dependencies>
    <dependency>
      <groupId>io.appium</groupId>
      <artifactId>java-client</artifactId>
      <version>9.1.0</version>
    </dependency>
  </dependencies>
</project>
EOL
    
    # Create sample iOS test
    mkdir -p src/main/java/com/example
    cat <<EOL > src/main/java/com/example/IOSSimulatorTest.java
package com.example;
import io.appium.java_client.ios.IOSDriver;
import java.net.URL;
import org.openqa.selenium.remote.DesiredCapabilities;

public class IOSSimulatorTest {
    public static void main(String[] args) throws Exception {
        DesiredCapabilities caps = new DesiredCapabilities();
        caps.setCapability("platformName", "iOS");
        caps.setCapability("platformVersion", "17.0");
        caps.setCapability("deviceName", "iPhone 15");
        caps.setCapability("automationName", "XCUITest");
        caps.setCapability("app", "/path/to/your/ios-simulator-app.app");
        IOSDriver driver = new IOSDriver(new URL("http://127.0.0.1:4723"), caps);
        System.out.println("iOS Simulator test started.");
        driver.quit();
    }
}
EOL
    
    # Create sample Android test
    cat <<EOL > src/main/java/com/example/AndroidEmulatorTest.java
package com.example;
import io.appium.java_client.android.AndroidDriver;
import java.net.URL;
import org.openqa.selenium.remote.DesiredCapabilities;

public class AndroidEmulatorTest {
    public static void main(String[] args) throws Exception {
        DesiredCapabilities caps = new DesiredCapabilities();
        caps.setCapability("platformName", "Android");
        caps.setCapability("platformVersion", "14");
        caps.setCapability("deviceName", "emulator-5554");
        caps.setCapability("automationName", "UiAutomator2");
        caps.setCapability("app", "/path/to/your/android-app.apk");
        AndroidDriver driver = new AndroidDriver(new URL("http://127.0.0.1:4723"), caps);
        System.out.println("Android Emulator test started.");
        driver.quit();
    }
}
EOL
    
    # Resolve dependencies
    mvn dependency:resolve
    if [ $? -ne 0 ]; then
        echo "Failed to resolve Appium dependencies."
        exit 1
    fi
    echo "Sample Appium project created."
else
    echo "Appium project directory already exists."
fi

# 10. Verify Setup
echo "Verifying installed tools..."
java -version || { echo "Java verification failed."; exit 1; }
mvn --version || { echo "Maven verification failed."; exit 1; }
node --version || { echo "Node.js verification failed."; exit 1; }
npm --version || { echo "npm verification failed."; exit 1; }
appium --version || { echo "Appium verification failed."; exit 1; }
adb version || { echo "Android SDK verification failed."; exit 1; }
xcrun simctl list devices || { echo "Xcode verification failed."; exit 1; }
echo "All tools verified."

# Cleanup
echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "Setup complete! To run the sample Appium tests:"
echo "1. Start Appium server: 'appium &'"
echo "2. Start an iOS Simulator or Android Emulator"
echo "3. Update app paths in IOSSimulatorTest.java and AndroidEmulatorTest.java"
echo "4. cd appium-test"
echo "5. Run iOS test: mvn compile exec:java -Dexec.mainClass=\"com.example.IOSSimulatorTest\""
echo "6. Run Android test: mvn compile exec:java -Dexec.mainClass=\"com.example.AndroidEmulatorTest\""
echo "Note: Source ~/.zshrc or restart terminal if environment variables don’t work."