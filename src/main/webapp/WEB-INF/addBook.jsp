<%--
  Created by IntelliJ IDEA.
  User: alanlytton
  Date: 1/11/23
  Time: 2:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>
<html>
<head>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css"/>
    <title>Book Club | Add Book</title>
</head>
<body>
<div class="container d-flex flex-column">
    <div class="container d-flex justify-content-between mt-3 mb-5">
        <h3>Add a book to your shelf! </h3>
        <a href="/home">Back to the shelves</a>
    </div>
    <div class="container d-flex flex-column align-items-center">
        <form:form action="/books/new" modelAttribute="newBook" method="post">
            <div class="container d-flex flex-column">
                <p class="text-danger"><form:errors path="title"/></p>
                <p>
                    <form:label path="title" cssClass="me-4">Title: </form:label>
                    <form:input cssClass="ms-5" path="title"/>
                </p>
            </div>
            <div class="container d-flex flex-column">
                <p class="text-danger"><form:errors path="author"/></p>
                <p>
                    <form:label path="author" cssClass="me-2">Author: </form:label>
                    <form:input cssClass="ms-5" path="author"/>
                </p>
            </div>
            <div class="container d-flex flex-column">
                <p class="text-danger"><form:errors path="thoughts"/></p>
                <p>
                    <form:label path="thoughts" cssClass="me-1">My Thoughts: </form:label>
                    <form:textarea cssClass="ms-2" path="thoughts"></form:textarea>
                </p>
            </div>
            <input type="submit" value="Add Book" class="btn btn-primary ms-2 mt-3">
        </form:form>
    </div>
</div>

    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
