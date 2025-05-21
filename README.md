# :smiley_cat: All about Tomcat

### **1. Servlet Lifecycle Management**
A container controls the entire lifecycle of a Servlet through three key methods:  
```java
public class MyServlet extends HttpServlet {
    // 1. Born (Container calls this once)
    public void init(ServletConfig config) throws ServletException {
        System.out.println("Servlet initialized!");
    }

    // 2. Working (Handles requests)
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) { ... }

    // 3. Death (Container calls this before destroying)
    public void destroy() {
        System.out.println("Servlet destroyed!");
    }
}
```
#### **What the Container Does:**
| **Lifecycle Stage** | **Container’s Role**                                                                 |
|---------------------|-------------------------------------------------------------------------------------|
| **Initialization**  | Calls `init()` once when the Servlet is first loaded (e.g., on startup or first request). |
| **Request Handling**| Creates threads to call `doGet()`, `doPost()`, etc., for each HTTP request.          |
| **Destruction**     | Calls `destroy()` when shutting down (e.g., to release database connections).        |

**Key Point:** You *never* call these methods directly—the container does!

---

### **2. Threading & Concurrency**
- The container **creates a new thread** for each incoming request (so multiple users can use the Servlet simultaneously).  
- Your `doGet()`/`doPost()` code must be **thread-safe** (avoid shared mutable state).  

#### **Example:**
```java
// UNSAFE (Shared variable across threads!)
public class BadServlet extends HttpServlet {
    int count = 0; // Danger! Race condition!
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {
        count++;
    }
}
```
The container’s threading model is why Servlets are **scalable** but require careful coding.

---

### **3. Request/Response Handling**
The container wraps raw HTTP traffic into Java objects:  
- **`HttpServletRequest`**: Contains HTTP headers, parameters, body.  
- **`HttpServletResponse`**: Lets you set status codes, headers, and write output.  

#### **Behind the Scenes:**
1. You visit `http://localhost:8080/hello?name=Alice`.  
2. The container:  
   - Parses the URL and parameters.  
   - Creates `HttpServletRequest`/`HttpServletResponse` objects.  
   - Passes them to your `doGet()` method.  

---

### **4. Deployment & Configuration**
Servlets are deployed via:  
- **`web.xml` (Traditional)**  
  ```xml
  <web-app>
    <servlet>
      <servlet-name>hello</servlet-name>
      <servlet-class>com.example.HelloServlet</servlet-class>
    </servlet>
    <servlet-mapping>
      <servlet-name>hello</servlet-name>
      <url-pattern>/hello</url-pattern>
    </servlet-mapping>
  </web-app>
  ```
- **Annotations (Modern)**  
  ```java
  @WebServlet("/hello")
  public class HelloServlet extends HttpServlet { ... }
  ```
The container reads these and maps URLs to Servlets.

---

### **5. Memory & Resource Management**
- **Classloading**: The container loads/unloads Servlet classes (e.g., during hot deployment).  
- **Pooling**: Reuses Servlets instead of creating new instances per request.  
- **Cleanup**: Calls `destroy()` to release resources (e.g., closing database connections).  

---

### **6. Security**
The container handles:  
- Authentication (e.g., login pages).  
- Authorization (e.g., role-based access via `@RolesAllowed`).  
- HTTPS/SSL termination.  

---

### **7. Error Handling**
- Catches exceptions thrown by Servlets.  
- Shows default error pages or custom ones (configured in `web.xml`).  

---

### **Key Takeaways**
1. **Containers are invisible superheroes**: They handle everything low-level so you can focus on `doGet()`/`doPost()`.  
2. **Threading is automatic but dangerous**: Shared state causes bugs (race conditions).  
3. **Lifecycle matters**: Use `init()` for startup tasks (e.g., DB connections), `destroy()` for cleanup.  

---

### **Experiment to Try**
1. Add `System.out.println("Thread: " + Thread.currentThread().getId())` to your `doGet()`.  
   - Refresh the page multiple times—see different thread IDs!  
2. Add a `sleep(5000)` to simulate slow processing.  
   - Open two browser tabs—note how the container handles concurrent requests.  

This will solidify how containers manage Servlets in practice.