#!/bin/bash

# === CONFIG ===
TOMCAT_WEBAPPS_PATH="/Users/skumar21/Documents/apache-tomcat-9.0.104/webapps"  # <== Replace this with your Tomcat path - /path/to/tomcat/webapps
CONFIG_FILE="src/main/resources/config.properties"
POM_FILE="pom.xml"
APP_NAMES=("ROOT" "dashboard" "analytics")

for APP in "${APP_NAMES[@]}"
do
  echo "🔧 Building and deploying: $APP"

  # Step 1: Update config.properties if not ROOT
  if [[ "$APP" != "ROOT" ]]; then
    echo "✍️  Updating app.name in $CONFIG_FILE to '$APP'"
    sed -i.bak "s|^app.name=.*|app.name=$APP|" "$CONFIG_FILE"
  else
    echo "➡️  Skipping app.name update for ROOT (keeping default)"
  fi

  # Step 2: Update <finalName> in pom.xml
  echo "✍️  Updating <finalName> in $POM_FILE to '$APP'"
  sed -i.bak "s|<finalName>.*</finalName>|<finalName>$APP</finalName>|" "$POM_FILE"

  # Step 3: Build the WAR
  echo "🔨 Building the WAR"
  mvn clean package

  # Step 4: Copy WAR to Tomcat
  WAR_FILE="target/$APP.war"
  if [[ -f "$WAR_FILE" ]]; then
    echo "🚚 Copying $WAR_FILE to $TOMCAT_WEBAPPS_PATH/"
    cp "$WAR_FILE" "$TOMCAT_WEBAPPS_PATH/"
    echo "✅ Deployed $APP.war"
  else
    echo "❌ WAR not found: $WAR_FILE"
  fi

  echo "------------------------------"
done