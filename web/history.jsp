<%@page import="java.util.Iterator"%>
<%@page import="main.Car"%>
<%@page import="main.Order"%>
<%@page import="main.User"%>
<%@page import="main.LevelOfEquipment"%>
<%@page import="main.EngineType"%>
<%@page import="main.Color"%>
<%@page import="main.Model"%>
<%@page import="main.DB"%>
<%@page import="main.Brand"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    User user = (User) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("index.html");
        return;
    }

    String query = "SELECT o, u, c, l, co, m, b, e FROM Order o ";
    query += "LEFT JOIN o.car c ";
    query += "LEFT JOIN o.user u ";
    query += "LEFT JOIN c.levelOfEquipment l ";
    query += "LEFT JOIN c.color co ";
    query += "LEFT JOIN c.model m ";
    query += "LEFT JOIN m.brand b ";
    query += "LEFT JOIN m.engineType e ";
    query += "WHERE u.id=?";

    List<Order> datas = DB.query(query, user.getId());
    request.setAttribute("datas", datas);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/styles.css" type="text/css" rel="stylesheet">
        <title>Cart</title>
    </head>
    <body>
        <table>
            <tr>
                <th>Order#</th>
                <th>Brand</th>
                <th>Model</th>
                <th>Level Of Equipment</th>
                <th>Engine Type</th>
                <th>Color</th>
                <th>Price($)</th>
            </tr>
            <c:forEach var="d" varStatus="forstatus" items="${datas}">
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
