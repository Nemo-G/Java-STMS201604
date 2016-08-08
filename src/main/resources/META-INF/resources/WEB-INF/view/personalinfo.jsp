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
<link rel="stylesheet"
	href="css/validationEngine.jquery.css">

</head>

<body>
	<div id='wrapper'>
		<%@ include file="template/nav-head.jsp"%>

		<div id="page-wrapper">
			<div class="container-fluid">
				<div class="col-lg-12">
					<h1 class="page-header">Personal Information</h1>
				</div>
				<div class="row">
					<div class="col-lg-10">
						<div class="panel panel-info">
							<div class="panel-heading">
								<p>Login ID : ${uid}</p>
							</div>
							<div class="panel-body">
								<form role="form" action="/modify" method="POST" id="fm">
									<input type="hidden" name="uid" value="${uid}">
									<input type="hidden" name="_csrf" value="${_csrf.token}" />
									<input type="hidden" name="_csrf_header" value="${_csrf.headerName}" />
									<div class="form-group input-group">
										<span class="input-group-addon">Name</span> <input type="text"
											class="form-control validate[required]" name="name" value="${invi.name}">
									</div>
									<div class="form-group input-group">
										<span class="input-group-addon">Password</span> <input
											type="text" class="form-control validate[required]" name="password"
											value="${invi.password}">

									</div>
									<div class="form-group input-group">
										<span class="input-group-addon">Email</span> <input
											type="text" class="form-control validate[required,custom[email]]" name="email"
											value="${invi.email}">
									</div>
									<div class="form-group input-group">
										<span class="input-group-addon">Phone</span> <input
											type="text" class="form-control validate[required,custom[integer]]" name="phone"
											value="${invi.phone}">
									</div>
									<div class="form-group input-group">
										<span class="input-group-addon">BankAccount</span> <input
											type="text" class="form-control validate[required]" name="bankaccount"
											value="${invi.bankaccount}">
									</div>

								</form>
							</div>
							<div class="panel-footer">
								<c:if test="${param.modify eq 'OK'}">
									<p style='color: red'>Successfully Modified.</p>
								</c:if>
								<button type="button"
									class="btn btn-primary"
									data-toggle="modal" data-target="#myModal">Submit</button>
									
								<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
									aria-labelledby="myModalLabel" aria-hidden="true"
									style="display: none;">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal"
													aria-hidden="true"><i class="fa fa-fw fa-minus-circle"></i></button>
												<h4 class="modal-title" id="myModalLabel">Warings</h4>
											</div>
											<div class="modal-body">You are now modifying your
												personal information. Please make sure that you got all
												items right, otherwise you can't get latest information and
												notifications.</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default"
													data-dismiss="modal">Cancel</button>
												<button type="button" class="btn btn-primary"
													data-dismiss="modal" onclick="onSubmitCheck()">Save changes</button>
											</div>
										</div>
										<!-- /.modal-content -->
									</div>
									<!-- /.modal-dialog -->
								</div>
							</div>
						</div>


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
	 <script src="js/jquery.validationEngine-en.js"></script>
    <script src="js/jquery.validationEngine.js"></script>
	<script>

	function onSubmitCheck() {
		if($("#fm").validationEngine('validate'))
			document.getElementById('fm').submit();
	}
</script>
</body>
</html>