# :smiley_cat: All about Tomcat

## :black_square_button: What Does a Servlet Container Do?
1. Request Handling: It listens for incoming HTTP requests and routes them to appropriate servlets based on the URL mapping.

2. Servlet Lifecycle Management: It manages the lifecycle of servlets, including their initialization (init()), handling requests (service()), and destruction (destroy()).

3. Session Management: It manages HTTP sessions, which allows for maintaining user-specific data across multiple requests (useful for login systems, for example).

4. Servlet Security: It enforces security constraints defined in web.xml (such as authentication and authorization rules).

5. Servlet Deployment: It handles the deployment of web applications (servlets, JSPs) packaged as .war files.

## :clipboard: Setting up a Simple Apache Tomcat Server with a Servlet

#### 1. Create a Maven Project
Start by creating a Maven project. If you're using an IDE like IntelliJ IDEA or Eclipse, you can create the project using the following steps:

* Select Maven Project.

* Choose war as the packaging type.


#### 2. Create `pom.xml`

#### 3. Create the Servlet
Create a simple servlet in `src/main/java/com/example/servlets/StaticServlet.java`

#### 4. Configure the Servlet 
`webapp/WEB-INF/web.xml`

> Tomcat only treats the app as a `webapp` if it has a valid `WEB-INF/web.xml`. If `web.xml` is not configured, even the maven build process will fail as we have configured the `packaging` should be `war`.

This is how your project folder structure should look like :

```pgsql
myapp/
└── src/
|    ├── main/
|    │    ├── java/
|    │    |    └── com/example/servlets
|    │    |                      └── StaticServlet.java
|    │    └── webapp/
|    │          └── WEB-INF
|    │                └── web.xml
|    ├── test/
|    │    └── java/
└── pom.xml
```

#### 5. Build the Project

Once you've set up the project structure and files, build the project using Maven.

```bash
mvn clean package
```

This will create a `target/ROOT.war` file, which you can deploy on your Tomcat server.

> Reason for the name `ROOT.war` in `target` is this line of configuration `<build><finalName>ROOT</finalName></build>` in `pom.xml`.

#### 6. Deploy on Apache Tomcat

1. Download and install `Apache Tomcat` (if not already installed).
2. Copy the `war` file to the `webapps` directory of Tomcat.
   
    This is how Tomcat folder structure ideally looks like :

    ```pgsql
    TOMCAT_HOME/
    └── webapps/
    |    ├── myapp/
    |    │   ├── META-INF/
    |    │   └── WEB-INF/
    |    |       ├── classes/
    |    │       |     └── com/example/servlets
    |    │       |                       └── StaticServlet.class
    |    │       └── web.xml
    └── bin/
         ├── startup.sh
         └── shutdown.sh
    ```
3. Start the Tomcat server by running `bin/startup.sh` (Linux/Mac) or `bin/startup.bat` (Windows).

```bash
cd ~/path/to/TOMCAT_HOME/
chmod +x bin/startup.sh
./bin/startup.sh
```

#### 🔧 Prerequisites Before Running the Command

Ensure you have Java installed and JAVA_HOME is set:

* To check if Java is installed:

```bash
java -version
```

* To set JAVA_HOME temporarily:

```bash
export JAVA_HOME=/path/to/your/java
export PATH=$JAVA_HOME/bin:$PATH
```

#### 📌 Example

If successful, you'll see output like:

```swift
Using CATALINA_BASE:   /your/path/to/tomcat
Using CATALINA_HOME:   /your/path/to/tomcat
Using CATALINA_TMPDIR: /your/path/to/tomcat/temp
Using JRE_HOME:        /your/java/home
Using CLASSPATH:       /your/path/to/tomcat/bin/bootstrap.jar:/your/path/to/tomcat/bin/tomcat-juli.jar
Tomcat started.
```

Then open your browser at:
👉 http://localhost:8080


### :white_check_mark: Try `deploy-app.sh` Script, which automates above mentioned steps

```bash
chmod +x deploy-apps.sh
./deploy-apps.sh
```