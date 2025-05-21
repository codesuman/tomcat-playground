package com.example.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DynamicServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set the message that will be passed to the JSP
        request.setAttribute("message", "Welcome to the world of JSP and Servlets!");

        // Forward the request to hello.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("/hello.jsp");
        dispatcher.forward(request, response);
    }
}
