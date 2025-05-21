#!/bin/bash

# === CONFIG ===
TOMCAT_WEBAPPS_PATH="/path/to/tomcat/webapps"  # <== Replace this with your Tomcat path
POM_FILE="pom.xml"
APP="ROOT"

echo "🔧 Building and deploying: $APP"

# Step 1: Update <finalName> in pom.xml
echo "✍️  Updating <finalName> in $POM_FILE to '$APP'"
sed -i.bak "s|<finalName>.*</finalName>|<finalName>$APP</finalName>|" "$POM_FILE"

# Step 2: Build the WAR
echo "🔨 Building the WAR"
mvn clean package

# Step 3: Copy WAR to Tomcat
WAR_FILE="target/$APP.war"
if [[ -f "$WAR_FILE" ]]; then
echo "🗑️ Deleting $WAR_FILE in $TOMCAT_WEBAPPS_PATH/"
rm -rf "$TOMCAT_WEBAPPS_PATH/$APP.war"/*
rm -rf "$TOMCAT_WEBAPPS_PATH/$APP"/*
# Optionally, remove the directory itself (if it's empty after deleting contents)
rm -rf "$TOMCAT_WEBAPPS_PATH/$APP.war"
rm -rf "$TOMCAT_WEBAPPS_PATH/$APP"
echo "🚚 Copying $WAR_FILE to $TOMCAT_WEBAPPS_PATH/"
cp "$WAR_FILE" "$TOMCAT_WEBAPPS_PATH/"
echo "✅ Deployed $APP.war"
else
echo "❌ WAR not found: $WAR_FILE"
fi

echo "------------------------------"