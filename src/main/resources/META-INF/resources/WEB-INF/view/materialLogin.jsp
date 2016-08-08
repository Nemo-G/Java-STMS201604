<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<title>Admin Login</title>
	<link rel="stylesheet"
	href="/webjars/startbootstrap-sb-admin-2/1.0.2/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet"
	href="css/loginStyle.css">
</head>
<body>
	<div class="materialContainer">


   <div class="box">

      <div class="title">HR LOGIN</div>
      
      <form id='loginform' action="${loginUrl}" method='post'>
							<c:if test="${param.error != null}">
								<p style='color: red'>Invalid username and password.</p>
							</c:if>
							<c:if test="${param.logout != null}">
								<p style='color: red'>You have been logged out.</p>
							</c:if>

      <div class="input">
         <label for="name">Username</label>
         <input type="text" name="username" id="name">
         <span class="spin"></span>
      </div>

      <div class="input">
         <label for="pass">Password</label>
         <input type="password" name="password" id="pass">
         <span class="spin"></span>
      </div>

      <div class="button login">
         <button onclick="submitCheck()"><span>GO</span> <i class="fa fa-check"></i></button>
      </div>
	  </form>
	  	
      <a href="#" class="pass-forgot">Forgot your password?</a>

   </div>

   <div class="overbox">
      <!-- <div class="material-button alt-2"><span class="shape"></span></div> -->

      <div class="title">LOGIN</div>
      
      <div class="input">
         <label for="regname">Username</label>
         <input type="text" name="regname" id="regname">
         <span class="spin"></span>
      </div>

      <div class="input">
         <label for="regpass">Password</label>
         <input type="password" name="regpass" id="regpass">
         <span class="spin"></span>
      </div>

      <div class="input">
         <label for="reregpass">Repeat Password</label>
         <input type="password" name="reregpass" id="reregpass">
         <span class="spin"></span>
      </div>

      <div class="button">
         <button><span>NEXT</span></button>
      </div>


   </div>

</div>
	


<script src="/webjars/jquery/1.11.1/jquery.min.js"></script>
<script src="js/login.js"></script>
<script>
	function submitCheck() {
		if (document.getElementById('username').value === '' || 
			document.getElementById('password').value === ''){
			alert ('You must fill in both E-mail and Password!');
		    return false;
		}else
			document.getElementById('loginform').submit();
	}
</script>
</body>
</html>