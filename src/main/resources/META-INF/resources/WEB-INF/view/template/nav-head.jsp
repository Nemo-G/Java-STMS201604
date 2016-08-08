<nav class="navbar navbar-inverse navbar-static-top" role="navigation"
	style="margin-bottom: 0">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target=".navbar-collapse">
			<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
			<span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="/welcome"> Welcome ${usr.uid}</a>
	</div>


	<!-- Top Menu Items -->

	<ul class="nav navbar-top-links navbar-right">
		<li class="dropdown"><a class="dropdown-toggle"
			data-toggle="dropdown" href="#">New Message <i class="fa fa-bell fa-fw"></i><span id="ticketsum" class="badge" style="position: relative;top: -8px;left: -2px"><font id="notificationSum">0</font></span>
				<i class="fa fa-caret-down"></i>
		</a>
			<ul class="dropdown-menu dropdown-messages">
				<div id="head-message"></div>
				
			
				<li><a class="text-center" href="/welcome"> <strong>Read
							All Messages</strong> <i class="fa fa-angle-right"></i>
				</a></li>
			</ul> <!-- /.dropdown-messages --></li>
		<!-- /.dropdown -->
		
		<li class="dropdown">
		<a class="dropdown-toggle"
			data-toggle="dropdown" href="#"> 
			<i class="fa fa-user fa-fw"></i>
			<i class="fa fa-caret-down"></i>
		</a>
			<ul class="dropdown-menu dropdown-user">
				<li><a href="#"><i class="fa fa-user fa-fw"></i> User
						Profile</a></li>
				<li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a></li>
				<li class="divider"></li>
				<li><a href="/logout"><i class="fa fa-sign-out fa-fw"></i>
						Logout</a></li>
			</ul> <!-- /.dropdown-user -->
		</li>
		<!-- /.dropdown -->
	</ul>
	<!-- Top Menu Items -->

	
	<div class="sidebar sidebar-nav navbar-collapse" role="navigation">
		<div class="sidebar-nav navbar-collapse">
			<c:if test="${usr != null and usr.utype.utypeAuth eq 'HRM' }">
				<%@ include file="sidenav-admin.html"%>
			</c:if>

			<c:if test="${usr != null and usr.utype.utypeAuth != 'HRM'}">
				<%@ include file="sidenav-invi.html"%>
			</c:if>
		</div>
		
	</div>



</nav>
