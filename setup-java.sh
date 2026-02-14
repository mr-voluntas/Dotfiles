#!/bin/bash
set -e

echo "--- Installing Java 17 and Maven ---"
# jdk17-openjdk is the current Long Term Support (LTS) version
# maven is the standard build tool
pacman -S --noconfirm jdk17-openjdk maven

echo "--- Configuring Environment ---"
# Arch installs Java to a specific versioned path. 
# We link it to a generic path or export it directly.
JAVA_PATH="/usr/lib/jvm/java-17-openjdk"

# Update .zshrc so Maven and Java are always linked
{
    echo ""
    echo "# Java Configuration"
    echo "export JAVA_HOME=$JAVA_PATH"
    echo "export PATH=\$JAVA_HOME/bin:\$PATH"
} >> ~/.zshrc

echo "--- Verifying Installation ---"
export JAVA_HOME=$JAVA_PATH
export PATH=$JAVA_PATH/bin:$PATH
java -version
mvn -version

echo "--- Installating jdtls dependencies ---"
# python: for jdtls wrapper
# unzip: for mason to extract downloads
# lua-language-server: direct system install is often more stable in Arch
pacman -S --noconfirm python unzip lua-language-server
