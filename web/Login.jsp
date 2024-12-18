<%--
  Created by IntelliJ IDEA.
  User: 73643
  Date: 2022/4/3
  Time: 19:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html style="overflow: hidden" lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/Login.css">
    <script src="js/LoginStatus.js" type="text/javascript"></script>
    <script src="js/jquery-3.6.0.js" type="text/javascript"></script>
    <title>Login</title>
</head>

<body>
<div class="box">
    <div class="left">
        <img src="src/loginBG.png" class="bgImg">
    </div>
    <div class="right">
        <h4>登 录</h4>
        <form action="/MyWeb/Login">
<%--            <form action="/MyWeb/Login">--%>
            <input class="acc" name="username" type="text" placeholder="用户名">
            <input class="acc" name="password" type="password" placeholder="密码">
            <input class="submit" type="submit" value="Login" onclick=submitLoginMessage()>
        </form>
    </div>
</div>

<script type="text/javascript">
    function submitLoginMessage(){
        $.ajax({
            type:"get",
            url:"/MyWeb/Login",
            data:{
                username:$("input[name='username']").val(),
                password:$("input[name='password']").val(),
            },
            dataType:"text",
            success:function (userMsg){
                if(userMsg=="1"){
                    window.location.href = ("http://localhost:8010/MyWeb/openlayerLogged.jsp");
                }
                else{
                    alert("login failed");
                }
            }
        })
    }
</script>

</body>
</html>
