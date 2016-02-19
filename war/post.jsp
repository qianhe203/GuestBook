<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="java.util.Collections" %>

<%@ page import="com.googlecode.objectify.Objectify" %>

<%@ page import="com.googlecode.objectify.ObjectifyService" %>

<%@ page import="guestbook.Greeting" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 <html>

  <head>
  		<link href="\stylesheets\bootstrap.min.css" rel="stylesheet">
    	<link href="\stylesheets\blog.css" rel="stylesheet">
  </head>

  <body>
  
 <%

    String guestbookName = request.getParameter("guestbookName");
    if (guestbookName == null) {
        guestbookName = "default";
    }
    pageContext.setAttribute("guestbookName", guestbookName);
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();


%>
<div class="blog-masthead">
      <div class="container">
        <nav class="blog-nav">
          <a class="blog-nav-item" href="\ofyguestbook.jsp">Home</a>
          <a class="blog-nav-item active" href="\post.jsp">Post</a>
          <a class="blog-nav-item" href="#">About</a>
          <% if (user != null) { 
          	pageContext.setAttribute("user", user);	%>
          	<a class="blog-nav-item" href="<%= userService.createLogoutURL(request.getRequestURI()) %>"> Sign out</a> 
          <% } else {%>
          	<a class="blog-nav-item" href="<%= userService.createLoginURL(request.getRequestURI()) %>"> Sign in</a>  
          <% } %>
        </nav>
      </div>
    </div>
    <div class="container">

      <div class="blog-header">
     <% if (user != null) { %> 
		<p> What's on your mind? 
		</p>
	
	    <form action="/ofysign" method="post">
	      <div><textarea name="content" rows="3" cols="60"></textarea></div>
	      <div><input type="submit" value="Post" /></div>
	      <input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>
	    </form>   
     <% } else {
     %>   
      </div><!-- /.row -->
    </div><!-- /.container -->
     <script src="\js\bootstrap.min.js"></script>    
   </body>

</html>