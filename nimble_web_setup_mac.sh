#!/bin/bash

echo "Starting Playwright Java environment setup for macOS..."
echo "Checking and installing required tools..."

# Set variables
JAVA_VERSION=11
MAVEN_VERSION=3.9.6
JAVA_URL="https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.20%2B8/OpenJDK11U-jdk_x64_mac_hotspot_11.0.20_8.tar.gz"
MAVEN_URL="https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"
TEMP_DIR="/tmp/playwright_setup"
JAVA_DIR="/usr/local/java/jdk-11"
MAVEN_DIR="/usr/local/maven/apache-maven-${MAVEN_VERSION}"
SCRIPT_PATH="$(realpath "$0")"

# -----------------------------------
# 0. Ensure Script is Executable
# -----------------------------------
echo "Checking script permissions..."
if [ ! -x "$SCRIPT_PATH" ]; then
    echo "Script is not executable. Making it executable..."
    chmod +x "$SCRIPT_PATH"
    if [ $? -ne 0 ]; then
        echo "Failed to make script executable. Please run 'chmod +x $SCRIPT_PATH' manually and re-run."
        exit 1
    fi
    echo "Script permissions updated. For this run, you may need to execute it again with './setup_playwright_java.sh'."
fi

# Create temp directory if it doesn’t exist
mkdir -p "$TEMP_DIR"

# -----------------------------------
# 1. Check and Install Homebrew (package manager)
# -----------------------------------
echo "Checking for Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ $? -ne 0 ]; then
        echo "Failed to install Homebrew. Please install it manually from https://brew.sh."
        exit 1
    fi
    echo "Homebrew installed successfully."
    # Add Homebrew to PATH (for this session)
    eval "$(/opt/homebrew/bin/brew shellenv)" || eval "$(/usr/local/bin/brew shellenv)"
else
    echo "Homebrew is already installed."
fi

# -----------------------------------
# 2. Check and Install JDK 11
# -----------------------------------
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
            echo "Failed to install JDK. Please download and install JDK 11 manually from https://adoptium.net/."
            exit 1
        fi
        echo "JDK 11 installed to $JAVA_DIR."
    else
        echo "JDK 11 installed via Homebrew."
        JAVA_DIR=$(brew --prefix openjdk@11)
    fi
    # Set JAVA_HOME and update PATH
    echo "export JAVA_HOME=$JAVA_DIR" >> ~/.zshrc
    echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.zshrc
    source ~/.zshrc
    echo "JAVA_HOME and PATH updated. You may need to restart your terminal."
else
    echo "Java JDK $JAVA_VERSION is already installed."
fi

# -----------------------------------
# 3. Check and Install Maven
# -----------------------------------
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
            echo "Failed to install Maven. Please download and install Maven $MAVEN_VERSION manually from https://maven.apache.org/download.cgi."
            exit 1
        fi
        echo "Maven installed to $MAVEN_DIR."
    else
        echo "Maven installed via Homebrew."
        MAVEN_DIR=$(brew --prefix maven)
    fi
    # Update PATH
    echo "export PATH=$MAVEN_DIR/bin:\$PATH" >> ~/.zshrc
    source ~/.zshrc
    echo "PATH updated for Maven. You may need to restart your terminal."
else
    echo "Maven is already installed."
fi

# -----------------------------------
# 4. Create a Sample Playwright Project and Install Browsers
# -----------------------------------
echo "Setting up a sample Playwright Java project and ensuring browser binaries..."
if [ ! -d "playwright-test" ]; then
    mkdir playwright-test
    cd playwright-test
    
    # Create pom.xml
    cat <<EOL > pom.xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.example</groupId>
  <artifactId>playwright-test</artifactId>
  <version>1.0-SNAPSHOT</version>
  <dependencies>
    <dependency>
      <groupId>com.microsoft.playwright</groupId>
      <artifactId>playwright</artifactId>
      <version>1.47.0</version>
    </dependency>
  </dependencies>
</project>
EOL
    
    # Create a browser installer Java file
    mkdir -p src/main/java/com/example
    cat <<EOL > src/main/java/com/example/InstallBrowsers.java
package com.example;
import com.microsoft.playwright.*;
public class InstallBrowsers {
    public static void main(String[] args) {
        try (Playwright playwright = Playwright.create()) {
            playwright.chromium().launch().close();
            playwright.firefox().launch().close();
            playwright.webkit().launch().close();
            System.out.println("Browser binaries installed successfully.");
        }
    }
}
EOL
    
    # Create a sample test Java file
    cat <<EOL > src/main/java/com/example/PlaywrightTest.java
package com.example;
import com.microsoft.playwright.*;
public class PlaywrightTest {
    public static void main(String[] args) {
        try (Playwright playwright = Playwright.create()) {
            Browser browser = playwright.chromium().launch();
            Page page = browser.newPage();
            page.navigate("https://example.com");
            System.out.println(page.title());
            browser.close();
        }
    }
}
EOL
    
    # Resolve dependencies and download Playwright
    mvn dependency:resolve
    if [ $? -ne 0 ]; then
        echo "Failed to resolve Playwright dependencies. Check Maven installation and internet connection."
        exit 1
    fi
    
    # Install browser binaries
    mvn compile exec:java -Dexec.mainClass="com.example.InstallBrowsers"
    if [ $? -ne 0 ]; then
        echo "Failed to install Playwright browser binaries. Check Java and Maven setup."
        exit 1
    fi
    echo "Sample Playwright project created and browser binaries (Chromium, Firefox, WebKit) installed."
else
    echo "Playwright project directory already exists. Skipping creation."
fi

# -----------------------------------
# 5. Verify Setup
# -----------------------------------
echo "Verifying installed tools..."
java -version
if [ $? -ne 0 ]; then
    echo "Java verification failed. Check installation."
else
    echo "Java verified."
fi
mvn --version
if [ $? -ne 0 ]; then
    echo "Maven verification failed. Check installation."
else
    echo "Maven verified."
fi

# -----------------------------------
# Cleanup and Final Instructions
# -----------------------------------
echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "Setup complete! To run the sample Playwright script:"
echo "1. cd playwright-test"
echo "2. mvn compile exec:java -Dexec.mainClass=\"com.example.PlaywrightTest\""
echo "Note: Restart your terminal or run 'source ~/.zshrc' if environment variables (JAVA_HOME, PATH) don’t work immediately."