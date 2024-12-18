<%--stylesheet of index.jsp--%>
<%--update:3.16,2022--%>
<%--user:Aurosong--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Index</title>
    <link rel="stylesheet" type="text/css" href="css/style.css" charset="UTF-8">
    <script src="js/LoginStatus.js" type="text/javascript"></script>
</head>

<body>

<header>
    <a href="#" class="logo">Logo</a>
    <div class="rightSide">
        <div class="btns dayNight">
            <ion-icon name="moon-outline"></ion-icon>
            <ion-icon name="sunny-outline"></ion-icon>
        </div>
        <div class="btns menuToggle">
            <ion-icon name="menu-outline"></ion-icon>
            <ion-icon name="close-outline"></ion-icon>
        </div>
    </div>
</header>

<section class="main">
    <video src="src/video.mp4" autoplay loop muted type="mp4"></video>
<%--    <video width="100%" height="100%" controls autoplay loop muted type="mp4">--%>
<%--        <source src="./video.mp4">--%>
<%--    </video>--%>
    <img src="src/mask.png" class="mask">
    <h2 class="title">Title</h2>
    <p class="copyrightText">WebGis Groupwork , 3.15 - 2022</p>
</section>

<ul class="navigation">
    <li><a href="openlayerMap.jsp">Map</a> </li>
    <li><a href="message.html">Message</a> </li>
    <li><a href="Login.jsp">Login</a> </li>
    <li><a href="">Test</a> </li>
</ul>

<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
<script>
    let dayNight = document.querySelector('.dayNight')
    let menuToggle = document.querySelector('.menuToggle')
    let body = document.querySelector('body')
    let navigation = document.querySelector('.navigation')

    dayNight.onclick = function (){
        body.classList.toggle('dark')
        dayNight.classList.toggle('active')
    }

    menuToggle.onclick = function (){
        menuToggle.classList.toggle('active')
        navigation.classList.toggle('active')
    }

</script>

<!--
<div style="text-align: center">
    <h1><%= "Welcome to WebGIS System" %></h1><br/>
    <button type="button" id="mapBtn" onclick=jump()>访问地图</button>
</div>
-->

</body>

<!--
<script>
    function jump(){
        window.location.href="map.jsp";
    }
</script>
-->

</html>