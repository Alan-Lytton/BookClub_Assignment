<%--
  Created by IntelliJ IDEA.
  User: alanlytton
  Date: 1/11/23
  Time: 8:44 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css"/>
  <title>Book Club | Dashboard</title>
</head>
<body>
  <div class="container d-flex flex-column">
    <div class="container d-flex justify-content-between mt-4">
      <h1>Welcome <c:out value="${firstName}"/></h1>
      <p><a href="/logout" class="btn btn-primary">Logout</a></p>
    </div>
    <div class="container d-flex justify-content-between mt-3 mb-3">
      <h4>Books from everyone's shelves: </h4>
      <a href="/books/new">Add a book to my shelf</a>
    </div>
    <div class="container">
      <table class="table table-striped">
        <thead>
        <tr>
          <th>ID</th>
          <th>Title</th>
          <th>Author</th>
          <th>Posted By</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="book" items="${books}">
        <tr>
          <td><c:out value="${book.id}"/></td>
          <td><a href="/books/${book.id}"><c:out value="${book.title}"/></a></td>
          <td><c:out value="${book.author}"/></td>
          <td><c:out value="${book.user.firstName}"/></td>
        </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

  <script src="/webjars/jquery/jquery.min.js"></script>
  <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
