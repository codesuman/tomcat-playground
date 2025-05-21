# :smiley_cat: All about Tomcat

## :rocket: Deploy Multiple Servlet Apps in Apache Tomcat
This project demonstrates how to deploy multiple Servlet-based applications using Apache Tomcat, each with its own config.properties.

### :file_folder: Project Structure
Each app should follow a Maven structure:

```css
your-app/
├── src/
│   ├── main/
│   │   ├── java/...          ← Your Servlet code
│   │   ├── resources/config.properties
│   │   └── webapp/...        ← JSP/HTML files
├── pom.xml
```

### :test_tube: Deployment Steps

For each application: `ROOT`, `dashboard`, `analytics`:

```bash
for APP in ROOT dashboard analytics
do
  # 1. Change values in config.properties specific to $APP
  vi src/main/resources/config.properties

  # 2. Update <finalName> in pom.xml to match the desired WAR name
  #    <build>
  #      <finalName>$APP</finalName>
  #    </build>

  # 3. Package the app
  mvn clean package

  # 4. Move the generated WAR to Tomcat's webapps folder
  cp target/$APP.war /path/to/tomcat/webapps/
done
```

> :repeat: Repeat the above steps for each distinct application.

### :package: WAR Naming & Access

| WAR File | Deployed As | URL |
| :---         |     :---:      |          ---: |
| `ROOT.war` |  `/` (default root) | `http://localhost:8080/`    |
| `AppOne.war` | `/dashboard` | `http://localhost:8080/dashboard/` |
| `AppTwo.war` | `/analytics` | `http://localhost:8080/analytics/` |

### :arrow_forward: Start Tomcat
```bash
cd /path/to/tomcat/bin
./startup.sh    # (Linux/macOS)
# OR
startup.bat     # (Windows)
```

### :white_check_mark: Verify
Visit in browser:

* http://localhost:8080/

* http://localhost:8080/dashboard/

* http://localhost:8080/analytics/

Each app will serve its own servlet and load its own config.properties.

### :hammer_and_wrench: Behind the Scenes:

* When Tomcat starts, it scans the `webapps/` folder.

> :gear: Internally, each WAR is its own isolated web application:

* For each `.war` file or directory:

  * It extracts (or uses) the war name as the **context path**.

  * Initializes a separate `ServletContext` for it.
  
  * ClassLoader

  * config.properties file

  * Logs (if configured separately)

  * Namespace

> :file_folder: Each folder (or .war file) inside tomcat/webapps/ automatically becomes a distinct context path.



### :white_check_mark: Final `deploy-apps.sh` Script (with config.properties update)

```bash
#!/bin/bash

# === CONFIG ===
TOMCAT_WEBAPPS_PATH="/path/to/tomcat/webapps"  # <== Replace this with your Tomcat path
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
```

```bash
chmod +x deploy-apps.sh
./deploy-apps.sh
```

### :repeat: After Running
This script will:

* Update app.name=dashboard or analytics in config.properties automatically

* Leave it unchanged for ROOT

* Change <finalName> in your pom.xml

* Build and deploy WARs to your Tomcat webapps/ directory