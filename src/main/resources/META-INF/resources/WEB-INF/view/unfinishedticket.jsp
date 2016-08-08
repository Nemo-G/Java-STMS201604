<!DOCTYPE html>
<html>
<head>
<title>Handle Ticket</title>


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
	href="/css/bootstrap-multiselect.css" rel="stylesheet">
</head>

<body>
	<%@ include file="template/nav-head.jsp"%>

	<div id="page-wrapper">
		<div class="container-fluid">
			<div class="col-lg-10">
				<h1 class="page-header">Unfinished Tickets</h1>
			<div class="row">
			<div class="col-lg-4">
			   <div class="form-group input-group">
               <input id="filter" type="text"  class="form-control" placeholder="Search Table">
               <span class="input-group-btn">
                  <button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
               </span>
               </div>
            </div>
            <div class='col-lg-2'>
            	<select class='form-control' id='showastype'>
            		<option value="">All Records</option>
            		<option>Unchecked</option>
            		<option>Assigning Worker</option>
            		<option>Worker Accepted</option>
            		<option>Ticket Printed</option>
            		<option>Finished</option>
            	</select>
            </div>
            <div class="col-lg-2"></div>
            
            <div class='col-lg-2'><button type='button' 
            							  class="btn btn-outline btn-success form-control"
            							  data-toggle="tooltip" data-html="true"
            							  title="This will update 'Ticket Printed' <br/>Set ticket fee to 0 .<br/> Set all worker evaluations to 5.<br/>Set ticket status to Finished." 
            							  onclick="updateTicketStatus()">Batch Evaluate</button></div>
            <div class='col-lg-2'>
            	<a href='/ticket/unfinished' type='button' class="btn btn-outline btn-primary form-control">Show All Records</a>
            	      
            </div>
            </div>
			<div class="row">
				<div class="col-lg-12">
			
						<div class="panel panel-primary">
							
							<div class="table-responsive">
                                <table id="ticketTable" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Ticket ID <i class="fa fw fa-sort"></i></th>
                                            <th>Customer Phone <i class="fa fw fa-sort"></i></th>
                                            <th>Created Time <i class="fa fw fa-sort"></i></th>
                                            <th>Ticket Type <i class="fa fw fa-sort"></i></th>
                                            <th >Processing Status <i class="fa fw fa-sort"></i></th>
                                          
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${ticketList}" var="ticket">
                                        <tr class="ticketRow ${tableStyle[ticket.statusId]} ${ticket.tid}" >
                                            <td>${ticket.tid}</td>
                                            <td>${ticket.consumerPhone}</td>
                                            <td>${ticket.createdTime}</td>                                         	
                                            <td class='problemtypeId'>${ticket.problemtype}</td>
                                            <td align='center' style=" width:200px;padding: 0px">
                                            <button type="button" class="btn btn-outline btn-primary" 
                                            	onClick="process('${ticket.tid}')" style="width:180px"
                                            	data-toggle="modal" data-target="#myModal" >${Status[ticket.statusId]}</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
					  </div>
					 
												<%@ include file="template/handle-ticket.html"%>
											
					  

				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			</div>
		</div>
		<!-- /.container-fluid -->
	</div>

   

	<script src="/webjars/jquery/1.11.1/jquery.min.js"></script>
	<script src="/webjars/startbootstrap-sb-admin-2/1.0.2/js/bootstrap.min.js"></script>
	<script src="/webjars/startbootstrap-sb-admin-2/1.0.2/js/sb-admin-2.js"></script>
	<script src="/webjars/startbootstrap-sb-admin-2/1.0.2/js/plugins/metisMenu/metisMenu.min.js"></script>
	<script src="/js/jquery.tablesorter.min.js"></script>
	<script src="/js/bootstrap-multiselect.js"></script>
	<script src="/js/worker-client.js"></script>
    <script src="/js/handleticket.js"> </script>
    <script>
    $(function(){
    	$('#ticketTable').tablesorter()
    	$('[data-toggle="tooltip"]').tooltip();
    	    
    	//new TableSorter(document.getElementById("ticketTable"));
    	var skillList = {}
    	//prevent reload using localStorage
    	if (localStorage.getItem("skillList") !== null){
    		skillList = JSON.parse(localStorage.getItem("skillList"));
    		showSkillList(skillList)
    		
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
    	
    	//pass ticketid to this page, help handle request from notifications
    	var key = '${param.key}'
    	$('#showastype')[0].value = key
    	if (key!==''){
    		$.each($("#ticketTable").find(".ticketRow"), function() {
    	        if($(this).text().toLowerCase().indexOf(key.toLowerCase()) === -1)
    	           $(this).hide();
    	        else
    	           $(this).show();                
    	      });
    		//$('#filter')[0].value = key
    		
    	}
    		
    	
    	
    });
    
    
    $('#filter').keyup(function(e){
		  //console.log(e.target.value)
  		var key = '${param.key}'
  		console.log(key)
	      $.each($("#ticketTable").find(".ticketRow"), function() {
	        if($(this).text().toLowerCase().indexOf(e.target.value.toLowerCase()) === -1||
	        		$(this).text().toLowerCase().indexOf(key.toLowerCase()) === -1	)
	           $(this).hide();
	        else
	           $(this).show();                
	      });
	    }
	);
    </script>
</body>
</html>