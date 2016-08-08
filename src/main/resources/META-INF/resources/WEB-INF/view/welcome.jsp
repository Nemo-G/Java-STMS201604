<!DOCTYPE html>
<html>
<head>
<title>Welcome HR</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <link rel="stylesheet"
	href="/webjars/bootstrap/3.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/webjars/startbootstrap-sb-admin-2/1.0.2/css/sb-admin-2.css">
<link rel="stylesheet"
	href="/webjars/startbootstrap-sb-admin-2/1.0.2/font-awesome/css/font-awesome.min.css">
<link
	href="/webjars/startbootstrap-sb-admin-2/1.0.2/css/plugins/metisMenu/metisMenu.min.css"
	rel="stylesheet"> 
<link
	href="/css/typehead.css"
	rel="stylesheet"> 
<link
	href="/css/bootstrap-multiselect.css" rel="stylesheet">
</head>

<body>
<div id="wrapper">
	<%@ include file="template/nav-head.jsp"%>

	<div id="page-wrapper">
		<div class="container-fluid">
			<div class="col-lg-12">
				<h1 class="page-header">Welcome ${usr.name}, your ID is ${usr.uid}</h1>
			<c:if test="${usr != null and usr.utype.utypeAuth eq 'HRM' }">
			
			<div class="row">
			<div class="col-lg-6">
				<div class="row">
            		<div class="col-lg-6">
                      <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-tasks fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">Ticket Start</div>
                                    
                                </div>
                            </div>
                        </div>
                        <a href="#" data-toggle="modal" data-target="#NewTicket" onclick="initAutocomplete()">
                            <div class="panel-footer">
                                <span class="pull-left"> Guide Me </span>
                                <span class="pull-right"> 
                                <i class="fa fa-arrow-circle-right" >
                                </i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                           	 <div class="modal fade" id="NewTicket" tabindex="-1" role="dialog"
									aria-labelledby="myModalLabel" aria-hidden="true"
									style="display: none;">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" id="dismiss-submit"
													aria-hidden="true" onclick="destroyAutocomplete()"><i class="fa fa-fw fa-minus-circle"></i></button>
												<h4 class="modal-title" id="myModalLabel">Ticket Guide</h4>
											</div>
											<div class="modal-body">
												<%@ include file="template/new-ticket-guide.jsp"%>
											</div>
										</div>
										<!-- /.modal-content -->
									</div>
									<!-- /.modal-dialog -->
								</div>
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="panel panel-green">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-edit fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">Candidates</div>
                                    
                                </div>
                            </div>
                        </div>
                        <a href="/infomanagement" target="blank">
                            <div class="panel-footer">
                                <span class="pull-left"> Check </span>
                                <span class="pull-right">
                                <i class="fa fa-arrow-circle-right">
                                </i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                      </div>
                    </div>
                </div>
                
				<div class="row">
				  <div class="col-lg-12">
						<div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-list-alt fa-fw"></i> Tickets
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="list-group">
                            	
                            	<div class="alert alert-danger"><i class="fa fa-tasks fa-fw"></i>
                                	Warning : You have <span class="badge">${uncheckedTickets}</span> tickets unchecked(Unchecked).
                                	<a href="/ticket/unfinished?key=unchecked" target="blank" > Click to process.</a>
                                </div> 
                                
                                <div class="alert alert-warning"><i class="fa fa-tasks fa-fw"></i>
                                	 You have <span class="badge">${AssignWorker}</span> tickets waiting for worker accept(Assign Worker).
                                	 <a href="/ticket/unfinished?key=Assigning Worker" target="blank"> Click to process.
                                	</a>
                                </div> 
                                
                                 <div class="alert alert-success"><i class="fa fa-tasks fa-fw"></i> 
                                	
                                	 You have <span class="badge">${WorkerAccepted}</span> ticket under processing(Worker Accepted).
                                	 <a href="/ticket/unfinished?key=Worker Accepted" target="blank"> Click to process.
                                	</a>
                                </div>
                                
        						<div class="alert alert-info" ><i class="fa fa-tasks fa-fw"></i>
        							
        							 You have <span class="badge">${TicketPrinted} </span> tickets about to complete(Ticket Printed).
        							 <a href="/ticket/unfinished?key=Ticket Printed" target="blank"> Click to process.
                                	</a>
                                </div>
                                
                            </div>
                            <!-- /.list-group -->
                                              							
								
                        </div>
                        <!-- /.panel-body -->
                             
                    </div>
            	  </div>
				</div>
                <!-- /.row -->
				</div>
			
				<div class="col-lg-6">
					<div class="panel panel-default">
			
                        <div class="panel-heading">
                            <i class="fa fa-bell fa-fw"></i> Message Box
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div id="wsResponse" class="list-group">   
                            	<c:forEach items="${unreadMessageList}" var="msg">
                            	<div class = "${msg.mcontent}" id = '${msg.mid}'>
    							<a href='#'  class='list-group-item alert' > 
    								
    								<span class='pull-right text-muted '> <em style="color:#31708f">${msg.createdtime}</em>   
    								&nbsp&nbsp&nbsp
    								<button onclick='readMsg(this)' type='button' class='close' data-dismiss='alert' aria-hidden='true'>
    								<i class='fa fa-trash-o'></i> 
    								</button>
    								</span> 
    								<div  data-toggle="modal" data-target="#myModal" onclick="process('${msg.mcontent}')">
    								<i class='fa fa-money fa-fw'></i> Ticket - #ID : <td>${msg.mcontent}</td>
    								</div>
    								
    							</a>
								</div>
                            	</c:forEach>              
                            </div>
                            <%@ include file="template/handle-ticket.html"%>
                            
                            
                            <!-- /.list-group -->
                        </div>
                        <!-- /.panel-body -->
                        <div class="panel-footer">
                        	<a href="javascript:void(0)" onclick="readAllMsg()">
                                <strong>Clear All</strong>
                            </a>
                        </div>
            		</div>
					
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			</c:if>
			</div>
			
		</div>
		<!-- /.container-fluid -->
	</div>
</div>


	<script src="/webjars/jquery/1.11.1/jquery.min.js"></script>
	<script src="/webjars/startbootstrap-sb-admin-2/1.0.2/js/bootstrap.min.js"></script>
	<script src="/webjars/startbootstrap-sb-admin-2/1.0.2/js/sb-admin-2.js"></script>
	<script src="/webjars/startbootstrap-sb-admin-2/1.0.2/js/plugins/metisMenu/metisMenu.min.js"></script>
	<script src="js/sockjs1.1.0.min.js"></script>
    <script src="js/stomp2.3.3.js"></script>
    <script src="/js/bootstrap-multiselect.js"></script>
    <script src="js/typehead.js"></script>
    <script src="js/validation.js"></script>
	<script src="js/newticket.js"></script>
	<script src="js/handleticket.js"></script>
	<script src="js/worker-home.js"></script>
	
	<script>
	ajaxOptions();
	function readMsg(btn){
    	var mid = $(btn).parent().parent().parent()[0].id;		
    	$.ajax({
    		url: '/rest/instantmsg/'+mid,
    		type: 'PATCH',
    		contentType: 'application/json',
    		data: JSON.stringify({
    			"hasread":true
    		}),
    		error: function() {
    			alert('Message Delete Error');
    		}
    	});
    }
	
	function readAllMsg(){
		$('.close').click()
	}
	
	$(function(){
	if (localStorage.getItem("skillList") !== null){
		skillList = JSON.parse(localStorage.getItem("skillList"));
		showSkillList(skillList)		
		//console.log(skillList)
	}else{//if not stored we do an ajax
	var xhr = new XMLHttpRequest(); 
		xhr.onreadystatechange = () =>{ 
			if (xhr.readyState === 4 && xhr.status === 200) {
				//console.log(skilldict)
				//var menulist = 
				JSON.parse(xhr.responseText)._embedded.skillconfig.map(
		        (skill)=>{
		        	skillList[skill.skillId] = skill.skillname
		        	//new Object({text:skill.skilldetail,value:skill.skillId})
		        	});
				//console.log(menulist)
				localStorage.setItem("skillList",JSON.stringify(skillList))	
				showSkillList(skillList)
			}
		};
		xhr.open("GET", "/rest/skillconfig");
	xhr.send();
	}
	})
	</script>

</body>
</html>