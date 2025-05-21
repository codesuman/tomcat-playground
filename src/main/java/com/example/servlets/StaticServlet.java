package com.example.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class StaticServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.getWriter().println("<h1>Hello from Static Servlet</h1>");
    }
}
