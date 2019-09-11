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
    List<Brand> brands = DB.query("SELECT b FROM Brand b");
    List<EngineType> engines = DB.query("SELECT e FROM EngineType e");
    List<LevelOfEquipment> equipments = DB.query("SELECT eq FROM LevelOfEquipment eq");
    List<Color> colors = DB.query("SELECT c FROM Color c");
    
    String selectedBrand = "";
    if(request.getParameter("selectedBrand") != null) {
        selectedBrand = request.getParameter("selectedBrand");
    } else {
        selectedBrand = brands.get(0).getId() + "";
    }
    String selectedModel = "";
    if(request.getParameter("selectedModel") != null) {
        selectedModel = request.getParameter("selectedModel");
    }
    String selectedEngine = "";
    if(request.getParameter("selectedEngine") != null) {
        selectedEngine = request.getParameter("selectedEngine");
    }
    String selectedEquipment = "";
    if(request.getParameter("selectedEquipment") != null) {
        selectedEquipment = request.getParameter("selectedEquipment");
    }
    String selectedColor = "";
    if(request.getParameter("selectedColor") != null) {
        selectedColor = request.getParameter("selectedColor");
    }
    request.setAttribute("models", null);
    if(!selectedBrand.isEmpty()) {
        List<Model> models = DB.query("SELECT m FROM Model m WHERE brand_id=?", Integer.parseInt(selectedBrand));
        request.setAttribute("models", models);
        Boolean exist = false;
        for(int i=0; i<models.size(); i++) {
            Model element = models.get(i);
            if(!selectedModel.isEmpty() && element.getId() == Integer.parseInt(selectedModel)) {
                exist = true;
                break;
            }
        }
        if(exist == false) {
            selectedModel = "";
        }
    }
    request.setAttribute("brands", brands);
    request.setAttribute("colors", colors);
    request.setAttribute("engines", engines);
    request.setAttribute("equipments", equipments);
    request.setAttribute("selectedBrandId", selectedBrand);
    request.setAttribute("selectedModelId", selectedModel);
    request.setAttribute("selectedEngineId", selectedEngine);
    request.setAttribute("selectedEquipmentId", selectedEquipment);
    request.setAttribute("selectedColorId", selectedColor);
%>

<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/styles.css" type="text/css" rel="stylesheet">
        <title>Choose Your Car</title>
    </head>
    <body>
        <script>
            function changeAction() {
                var searchForm = document.getElementById("searchForm");
                searchForm.action = "cart";
                searchForm.submit();
            }
        </script>
        <div class="login-page">
        <form id="searchForm" action="search.jsp" method="POST" class="form">
            <div>
                <h1 style="margin-bottom: 40px; font-weight: bolder">Choose Your Car</h1>
                <label>Choose Brand</label>
                <select class="select-css" name="selectedBrand" onchange="this.form.submit()">
                    <c:forEach var="b" items="${brands}">
                        <option
                            ${b.id == selectedBrandId ? "selected" : ""}
                            value="${b.id}"
                        >
                            ${b.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <br/>
            <div>
                <label>Choose Model</label>
                <select class="select-css" name="selectedModel" onchange="this.form.submit()">
                    <c:forEach var="m" items="${models}">
                        <option
                            ${m.id == selectedModelId ? "selected" : ""}
                            value="${m.id}"
                        >
                            ${m.name} - $${Math.round(m.price)}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <br/>
            <div>
                <label>Choose Engine</label>
                <select class="select-css" name="selectedEngine" onchange="this.form.submit()">
                    <c:forEach var="e" items="${engines}">
                        <option
                            ${e.id == selectedEngineId ? "selected" : ""}
                            value="${e.id}"
                        >
                            ${e.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <br/>
            <div>
               <label>Choose Equipment</label>
               <select class="select-css" name="selectedEquipment" onchange="this.form.submit()">
                   <c:forEach var="e" items="${equipments}">
                       <option
                           ${e.id == selectedEquipmentId ? "selected" : ""}
                           value="${e.id}"
                       >
                           ${e.name}
                       </option>
                   </c:forEach>
               </select>
            </div>
            <br/>
            <div>
                <label>Choose Color</label>
                <select class="select-css" name="selectedColor" onchange="this.form.submit()">
                    <c:forEach var="c" items="${colors}">
                        <option
                            ${c.id == selectedColorId ? "selected" : ""}
                            value="${c.id}"
                        >
                            ${c.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <button style="margin-top: 40px" onClick="changeAction()">Proceed to checkout</button>
            <button style="margin-top: 40px">Shopping History</button>
        </form>
        </div>    
    </body>
</html>
