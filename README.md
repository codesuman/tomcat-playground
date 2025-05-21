# :smiley_cat: All about Tomcat

## :clipboard: Setting up a Simple Apache Tomcat Server with a Servlet & JSP

#### 1. Create the Servlet
Create a simple servlet in `src/main/java/com/example/servlets/DynamicServlet.java`

#### 2. Configure the new Servlet 
`webapp/WEB-INF/web.xml`

This is how your project folder structure should look like :

```pgsql
myapp/
└── src/
|    ├── main/
|    │    ├── java/
|    │    |    └── com/example/servlets
|    │    |                      ├── StaticServlet.java
|    │    |                      └── DynamicServlet.java
|    │    └── webapp/
|    │          ├── hello.jsp
|    │          └── WEB-INF
|    │                └── web.xml
|    ├── test/
|    │    └── java/
└── pom.xml
```

#### 3. Build the Project

Once you've set up the project structure and files, build the project using Maven.

```bash
mvn clean package
```

This will create a `target/ROOT.war` file, which you can deploy on your Tomcat server.

#### 4. Deploy on Apache Tomcat

1. Copy the `war` file to the `webapps` directory of Tomcat.
   
    This is how Tomcat folder structure ideally looks like :

    ```pgsql
    TOMCAT_HOME/
    └── webapps/
    |    ├── myapp/
    |    │   ├── hello.jsp
    |    │   ├── META-INF/
    |    │   └── WEB-INF/
    |    |       ├── classes/
    |    │       |     └── com/example/servlets
    |    │       |                       ├── DynamicServlet.class
    |    │       |                       └── StaticServlet.class
    |    │       └── web.xml
    └── bin/
         ├── startup.sh
         └── shutdown.sh
    ```
2. Start the Tomcat server by running `bin/startup.sh` (Linux/Mac) or `bin/startup.bat` (Windows).

```bash
cd ~/path/to/TOMCAT_HOME/
chmod +x bin/startup.sh
./bin/startup.sh
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
👉 http://localhost:8080/dynamic


### :white_check_mark: Try `deploy-app.sh` Script, which automates above mentioned steps

```bash
chmod +x deploy-apps.sh
./deploy-apps.sh
```