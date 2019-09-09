<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/styles.css" type="text/css" rel="stylesheet">
        <title>Cart</title>
    </head>
    <body>
        <form class="cart-page">
            <div class="form-cart">            
                <h1>Your Order</h1>
                <hr style="margin-bottom: 35px">
                <div style="display: inline-block; float: left; width: 75%;">
                    <img alt="" src="https://cdn.motor1.com/images/mgl/gbWk8/s1/2017-mercedes-maybach-s550-review.jpg" height="100%" width="90%" style="border: solid 2px #000000 "> 
                    <label style="display: block; float: bottom; border-top: solid 1px black">PRICE : 170000$</label>
                </div>
                <div style="display: inline-block; width: 23%; margin-left: 2%">
                    <h2 style="margin-top: 0; border-bottom: solid 1px black">Mercedes</h2>
                    <label>Model</label>
                    <p>S550</p>
                    <label>Year of Production</label>
                    <p>2019</p>
                    <label>Engine</label>
                    <p>Petrol</p>
                    <label>Color</label><br>
                    <input  
                        style="box-shadow: ${selectedColorId == c.id ? "0px 0px 10px" : "0px 0px 0px"}; 
                               background-color: ${c.hex};
                               color: ${c.hex};
                               width: 20px; height: 20px;
                               border: 0px;
                               margin: 7.5px 0px 7.5px 0px;"
                        name="selectedColor" 
                        value="${c.id}"
                    >
                    <button onclick="alert('Car successfully bought!')">BUY CAR</button>
                </div>
            </div>
        </form>
    </body>
</html>
