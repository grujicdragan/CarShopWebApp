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
    User u = (User) session.getAttribute("user");
    if(u == null){
        response.sendRedirect("index.html");
        return;
    }
    String orderId = request.getParameter("orderId");
    if(orderId.isEmpty()) {
        response.sendRedirect("search.jsp");
        return;
    }

    String query = "SELECT o, c, l, co, m, b, e FROM Order o ";
    query += "LEFT JOIN o.car c ";
    query += "LEFT JOIN c.levelOfEquipment l ";
    query += "LEFT JOIN c.color co ";
    query += "LEFT JOIN c.model m ";
    query += "LEFT JOIN m.brand b ";
    query += "LEFT JOIN m.engineType e ";
    query += "WHERE o.id=?";

    List dbData = DB.query(query, Integer.parseInt(orderId));

    Iterator iter = dbData.iterator();

    Object[] data = (Object[]) iter.next();
    Order order = (Order) data[0];
    LevelOfEquipment levelOfEquipment = (LevelOfEquipment) data[2];
    Color color = (Color) data[3];
    Model model = (Model) data[4];
    Brand brand = (Brand) data[5];
    EngineType engineType = (EngineType) data[6];
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/styles.css" type="text/css" rel="stylesheet">
        <title>Cart</title>
    </head>
    <body>
        <form class="cart-page" action="submit" method="POST">
            <div class="form-cart">                         
                <h1 style="display: inline-block; margin-right: 185px">Your Order</h1>
                <button style="float: left; width: 190px; margin-top: 18px" 
                        onclick="location.href = 'http://localhost:8080/CarShopWebApplication/search.jsp';" 
                        type="button"
                        >Choose Another Car
                </button>  
                <hr style="margin-bottom: 35px">
                <div style="display: inline-block; float: left; width: 75%;">
                    <img src="<%= model.getImage()%>" alt="" height="100%" width="90%"> 
                    <label 
                        style="display: block; float: bottom; border-top: solid 1px black">
                        PRICE: $<%= Math.round(order.getPrice())%>
                    </label>
                </div>
                <div style="display: inline-block; width: 23%; margin-left: 2%">
                    <h2 style="margin-top: 0; border-bottom: solid 1px black"><%= brand.getName() %></h2>
                    <label>Model</label>
                    <p><%= model.getName() %></p>
                    <label>Year of Production</label>
                    <p><%= model.getYear()%></p>
                    <label>Equipment Package</label>
                    <p><%= levelOfEquipment.getName()%></p>
                    <label>Engine</label>
                    <p><%= engineType.getName()%></p>
                    <label>Color</label><br>
                    <br>
                    <div style="width: 100%; height: 20px;">
                        <div style="margin: auto; background-color: <%= color.getHex()%>; box-shadow: 0px 0px 2px black; width: 20px; height: 20px; border: 0px;"></div>
                    </div>
                    <br>
                    <input style="visibility: hidden" name="orderId" value="<%= order.getId() %>"/>
                    <button type="submit">BUY CAR</button>
                </div>
            </div>
        </form>
    </body>
</html>
