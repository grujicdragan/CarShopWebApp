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
                            ${m.name} - $${m.price}
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
                <div style="margin: 10px 0px 60px 0px; background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23007CB2%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E'),
      linear-gradient(to bottom, #ffffff 0%,#b3b3b3 100%);; border: 1px solid; border-radius: .5em;">
                <div>
                <c:forEach var="c" items="${colors}">
                    <input 
                        type="submit" 
                        style="box-shadow: ${selectedColorId == c.id ? "0px 0px 10px" : "0px 0px 0px"}; 
                               background-color: ${c.hex};
                               color: ${c.hex};
                               width: 20px; height: 20px;
                               border: 0px;
                               margin: 7.5px 0px 7.5px 0px;"
                        name="selectedColor" 
                        value="${c.id}"
                    >
                </c:forEach>
                </div>
                </div>    
            </div>
            <button onClick="changeAction()">Add to Cart</button>
        </form>
        </div>    
    </body>
</html>
