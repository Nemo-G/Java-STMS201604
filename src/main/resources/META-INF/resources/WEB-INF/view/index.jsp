<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<title> Login </title>
<link rel="stylesheet"
	href="/webjars/bootstrap/3.3.1/css/bootstrap.min.css"></link>
<link rel="stylesheet"
	href="/webjars/startbootstrap-sb-admin-2/1.0.2/css/sb-admin-2.css"></link>
</head>
<body>
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="navbar-brand">Login</div>
	</nav>


	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="login-panel panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Please Sign In</h3>
					</div>
					<div class="panel-body">
						<form id='loginform' action="${loginUrl}" method='post'>
							<c:if test="${param.error != null}">
								<p style='color: red'>Invalid username or password.</p>
							</c:if>
							<c:if test="${param.logout != null}">
								<p style='color: red'>You have been logged out.</p>
							</c:if>

							<fieldset>
								<div class="form-group">
									<input class="form-control" placeholder="UserId" id="username"
										name="username" type="username" autofocus>
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="Password"
										id="password" name="password" type="password" value="">
								</div>
								<div class="checkbox">
									<label> <input name="remember" type="checkbox"
										value="Remember Me">Remember Me
									</label>
								</div>
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />
								<button onclick='submitCheck()'
									class="btn btn-lg btn-primary btn-block">Login</button>
							</fieldset>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script>
	//to flush history data 
	//localStorage.clear()
	function submitCheck() {
		if (document.getElementById('username').value === '' || 
			document.getElementById('password').value === ''){
			alert ('You must fill in both E-mail and Password!');
		    return false;
		}else
			document.getElementById('loginform').submit();
	}
</script>

	<script src="/webjars/jquery/1.11.1/jquery.min.js"></script>
</body>
</html>