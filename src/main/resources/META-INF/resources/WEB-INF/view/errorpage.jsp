<!DOCTYPE html>
<html>
<head>
<title>Welcome</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
	href="/webjars/bootstrap/3.3.1/css/bootstrap.min.css"></link>
<link rel="stylesheet"
	href="/webjars/startbootstrap-sb-admin-2/1.0.2/css/sb-admin-2.css"></link>
<link rel="stylesheet"
	href="/webjars/startbootstrap-sb-admin-2/1.0.2/font-awesome/css/font-awesome.min.css">
<link
	href="/webjars/startbootstrap-sb-admin-2/1.0.2/css/plugins/metisMenu/metisMenu.min.css"
	rel="stylesheet">

</head>

<body>
	<div id='wrapper'>
		<%@ include file="template/nav-head.jsp"%>

		<div id="page-wrapper">
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-8">
						<div class="panel panel-danger">
							<div class="panel-heading">
								<h2>Opps!</h2>
							</div>
							<div class="panel-body">
								A problem has encountered! <br />Maybe you are not allowed to
								visit this page or the page doesn't even exist. <br />For more
								information, please contact admins.

							</div>
							<div class="panel-footer">
								Wait for <font style="color: red" id="showtime"></font> second
								or click <a href="/welcome" style='color: red'>here</a> and you
								will be redirect to homepages...
							</div>
						</div>
						<!-- /.col-lg-4 -->
					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.container-fluid -->
		</div>

	</div>

	<script src="/webjars/jquery/1.11.1/jquery.min.js"></script>
	<script
		src="/webjars/startbootstrap-sb-admin-2/1.0.2/js/bootstrap.min.js"></script>
	<script src="/webjars/startbootstrap-sb-admin-2/1.0.2/js/sb-admin-2.js"></script>
	<script
		src="/webjars/startbootstrap-sb-admin-2/1.0.2/js/plugins/metisMenu/metisMenu.min.js"></script>
	<script>
function timedMsg(c){	
	var hour=Math.floor(c/3600); 
	var minute=Math.floor((c-hour*3600)/60); 
	var second=Math.floor(c-hour*3600-minute*60); 
	/*
	if (minute <10) 
		minute="0"+minute;
	if (second <10) 
		second="0"+second;
	*/
	document.getElementById('showtime').innerHTML=second;
    if(c==0){
        //clearTimeout(t);
        console.log(c);
        //document.getElementById('c1').style.display="";
        window.location.href="/welcome";
    }else{
    //t=setTimeout(function(){timedMsg(c);},1000);
		setTimeout(function(){timedMsg(c);},1000);
    }
	return c--;
}

window.onload = function(){
	timedMsg(3);
}
</script>
</body>
</html>