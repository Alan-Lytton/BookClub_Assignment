<%--
  Created by IntelliJ IDEA.
  User: alanlytton
  Date: 1/11/23
  Time: 12:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>
<html>
<head>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css"/>
    <title>Book Club | <c:out value="${book.title}"/></title>
</head>
<body>
<div class="container d-flex flex-column">
    <div class="container d-flex justify-content-between mt-3 mb-3">
        <h2><c:out value="${book.title}"/></h2>
        <a href="/home">Back to dashboard</a>
    </div>
    <div class="container">
        <h3 class="mb-4">
            <c:choose><c:when test="${id == book.user.id}">You </c:when><c:otherwise><c:out value="${book.user.firstName} "/></c:otherwise></c:choose>read <c:out value="${book.title} "/>by <c:out value="${book.author}"/>
        </h3>
        <h5 class="mb-3">Here are <c:choose><c:when test="${id == book.user.id}">your </c:when><c:otherwise><c:out value="${book.user.firstName}'s"/></c:otherwise></c:choose> thoughts:</h5>
        <p class="border border-2 border-dark border-start-0 border-end-0 w-25 p-3"><c:out value="${book.thoughts}"/></p>
    </div>
    <span class="d-flex"><c:if test="${id == book.user.id}"><a href="/books/edit/${book.id}" class="btn btn-primary align-self-start me-1">Edit</a>
        <form action="/books/${book.id}/delete" method="post">
            <input type="hidden" name="_method" value="delete">
            <input type="submit" value="Delete" class="btn btn-danger ms-1">
        </form></c:if></span>

    <input type="hidden" name="_method" value="delete">

</div>

    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
