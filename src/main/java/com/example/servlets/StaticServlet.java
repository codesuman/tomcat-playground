package com.example.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class StaticServlet extends HttpServlet {
    private String appName;
    private String appVersion;

    @Override
    public void init() throws ServletException {
        try (InputStream input = getClass().getClassLoader().getResourceAsStream("config.properties")) {
            if (input != null) {
                Properties props = new Properties();
                props.load(input);
                appName = props.getProperty("app.name");
                appVersion = props.getProperty("app.version");
            } else {
                throw new ServletException("Could not load config.properties");
            }
        } catch (IOException e) {
            throw new ServletException("Failed to load config.properties", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.getWriter().println("<h1>Hello from Static Servlet</h1>");

        response.getWriter().println("<p>App Name: " + appName + "</p>");
        response.getWriter().println("<p>App Version: " + appVersion + "</p>");
    }
}
