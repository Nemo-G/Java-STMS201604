<!DOCTYPE html>
<html>
<head>
<title>WorkType Config</title>


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
</head>

<body>
	<%@ include file="template/nav-head.jsp"%>

	<div id="page-wrapper">
		<div class="container-fluid">
			<div class="col-lg-8">
				<h1 class="page-header">Worktype Configuration</h1>
			<div class="row">
				<div class="col-lg-4">
			   <div class="form-group input-group">
               <input id="filter" type="text"  class="form-control" placeholder="Search Table">
               <span class="input-group-btn">
                  <button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
               </span>
               </div>
            	</div>
				<div class="col-lg-8">
					 <button class="btn btn-outline btn-primary" data-toggle="modal" data-target="#myModal0" style="float: right">Add New Type</button>                            							
								<div class="modal fade" id="myModal0" tabindex="-1" role="dialog"
									aria-labelledby="myModalLabel" aria-hidden="true"
									style="display: none;">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal"
													aria-hidden="true"><i class="fa fa-fw fa-minus-circle"></i></button>
												<h4 class="modal-title" id="myModalLabel">New Work Type</h4>
											</div>
											
											<div  id="newSkill" class="modal-body">
												<div class="form-group">
												<label >Skill Name</label>
                                            		<input name="skillname" 
                                            		type="text" class="form-control" placeholder="Skill Name" required />
             										<div class="help-block with-errors"></div>
                                       			</div>
                                       			<div class="form-group">
                                       			<label >Skill Detail</label>
                                            		<input name="skilldetail" 
                                            		type="text" class="form-control" placeholder="Skill Detail" required>
                                            		<div class="help-block with-errors"></div>
                                       			</div>
                                       			<p id="insertStatus" style='color: red'></p>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default" data-dismiss="modal" >Close</button>
												<button type="button" class="btn btn-primary" onClick="insertSkillset()">Save</button>
											</div>
											
										</div>
										<!-- /.modal-content -->
									</div>
									<!-- /.modal-dialog -->
								 </div>	
				</div>
			</div>
				<div class='row'>
					<div class="col-lg-12">
						<div class="panel panel-primary">
							
							<div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Skill Name</th>
                                            <th>Skill Detail</th>
                                            <th>Employee Sum</th>
                                            <th>Operation</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${skillset}" var="skillItem" varStatus="loop">
                                        <tr id="${skillItem.skillId}">
                                            <td style="width:20%">
                                            	${skillItem.skillname}
                                            </td>
                                            <td style="width:30%">
                                            	${skillItem.skilldetail}
                                            </td>
                                            <td align='center' style="width:20%">
                                            	<c:out value="${empty employeeNum[loop.index] ? '0': employeeNum[loop.index]}" />
                                            </td>
                                            <td align='center' style="padding: 0px">
                                             <button type="button" class="btn btn-outline btn-success" data-toggle="modal" data-target="#myModal1" 
                                             onClick="setSkillInfo('${skillItem.skillId}')">
                                             	Update
                                             </button>
                                            <button type="button" class="btn btn-outline btn-danger" onClick="deleteSkillset('${skillItem.skillId}')">
                                            	Remove
                                            </button> 
                                            <label>
                                            Show to customer
                                            <input type="checkbox" checked/>
                                            </label>
                                            	
                                            
                                            </td>
                                        </tr>
                                       
                                    </c:forEach>
                                    </tbody>
                                   
                                </table>
                            </div>
					  </div>
					  
					  
							<p id="updateStatus" style='color: red'></p>
					  

				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			</div>
		</div>
		<!-- /.container-fluid -->
	</div>
	 <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal"
													aria-hidden="true"><i class="fa fa-fw fa-minus-circle"></i></button>
												<h4 class="modal-title" id="myModalLabel">Modify Work Type <font id='skillId'></font></h4>
											</div>
											<div id="modifySkill" class="modal-body" data-toggle='validator'>
												<div class="form-group">
                                           			<label>Skill Name</label>
                                            		<input id = 'skillName'
                                            		type="text" class="form-control" placeholder="Skill Name" required>
                                            		<div class="help-block with-errors"></div>
                                       			</div>
                                       			<div class="form-group">
                                           			<label>Skill Detail</label>
                                            		<input id = 'skillDetail'
                                            		type="text" class="form-control" placeholder="Skill Detail" required>
                                            		<div class="help-block with-errors"></div>
                                       			</div>
											</div>
											<div class="modal-footer">
												<button id='closeModal' type="button" class="btn btn-default" data-dismiss="modal">Close</button>
												<button type="button" class="btn btn-primary" onClick="updateSkill()">Update</button>
											</div>
										</div>
										<!-- /.modal-content -->
									</div>
									<!-- /.modal-dialog -->
								 </div>	
	 


	<script src="/webjars/jquery/1.11.1/jquery.min.js"></script>
	<script
		src="/webjars/startbootstrap-sb-admin-2/1.0.2/js/bootstrap.min.js"></script>
	<script src="/webjars/startbootstrap-sb-admin-2/1.0.2/js/sb-admin-2.js"></script>
	<script
		src="/webjars/startbootstrap-sb-admin-2/1.0.2/js/plugins/metisMenu/metisMenu.min.js"></script>
    <script src="js/validation.js"></script>
	<script src="js/worker-client.js"></script>

	<script>

		//update localStorage
		if (typeof localStorage.skillList !== 'undefined')
			localStorage.removeItem("skillList")
		
		$('#filter').keyup(function(e){
		  //console.log(e.target.value)
	      $.each($("tbody").find("tr"), function() {
	        if($(this).text().toLowerCase().indexOf(e.target.value.toLowerCase()) === -1)
	           $(this).hide();
	        else
	             $(this).show();                
	      });
	    }
		);
			
		function setSkillInfo(skillId){
			var skill = $('#'+skillId).find('td')
			document.getElementById('skillId').value = skillId
			document.getElementById('skillName').value = skill[0].innerText
			document.getElementById('skillDetail').value = skill[1].innerText
		}

		function updateSkill(){
			$('#modifySkill').validator('validate')
			if($('.list-unstyled').length!==0)return false;
			var skillData = {
					skillname:document.getElementById('skillName').value,
					skilldetail:document.getElementById('skillDetail').value
			}
			var skillId = document.getElementById('skillId').value
			$.ajax({
			      url: '/rest/skillconfig/'+skillId,
			      type: 'PATCH',
			      contentType: 'application/json',
			      data: JSON.stringify(skillData),
			      error: function() {
			         $('#updateStatus').html('Update Error');
			      },
			      dataType: 'json',
			      success: function(data) {
			    	  //console.log(data)
			    	  $('#updateStatus').html('Record '+skillId+' : Update Success');
			    	  timedMsg(1);
			      }				      
			   });
			$('#closeModal').click()
		}
		
		function deleteSkillset(id){
			//console.log(skillData)
			$.ajax({
			      url: '/rest/skillconfig/'+id,
			      type: 'DELETE',
			      error: function() {
			         $('#updateStatus').html('Delete Failed. You cannot DELETE a type with employed workers. ');
			      },
			      dataType: 'json',
			      success: function(data) {
			    	  //console.log(data)
			    	  $('#updateStatus').html(
			    			  "Delete Success, wait <font id='showtime'></font> second or click <a href='/skillconfig'></a>for the page to flush...");
			    	  timedMsg(2);
			      }				      
			   });
		}
		
		function insertSkillset(){
			$('#newSkill').validator('validate')
			if($('.list-unstyled').length!==0)return false;
			var skillData={}
			$($('#newSkill')).find("input[name]").each(function (index, node) {
		        skillData[node.name]=node.value 
		    });
			$.ajax({
			      url: '/rest/skillconfig/',
			      type: 'POST',
			      contentType: 'application/json',
			      data: JSON.stringify(skillData),
			      error: function() {
			         $('#insertStatus').html('Insert Error');
			      },
			      dataType: 'json',
			      success: function(data) {
			    	  console.log(data)
			    	  $('#updateStatus').html(
			    			  "Insert Success, wait <font id='showtime'></font> second or click <a href='/skillconfig'></a>for the page to flush...");
			    	  $('.close').click()
			    	  timedMsg(2);
			      }				      
			   });
		}
		
		$('[data-dismiss=modal]').click(function (){
			$('#newSkill').validator('destroy')
			$('#modifySkill').validator('destroy')
		})
		
		function timedMsg(c){	
			var hour=Math.floor(c/3600); 
			var minute=Math.floor((c-hour*3600)/60); 
			var second=Math.floor(c-hour*3600-minute*60); 
			$('#showtime').html(c)
		    if(c==0){
		        //clearTimeout(t);
		        console.log(c);
		        //document.getElementById('c1').style.display="";
		        window.location.href="/skillconfig";
		    }else{
		    //t=setTimeout(function(){timedMsg(c);},1000);
				setTimeout(function(){timedMsg(c);},1000);
		    }
			return c--;
		}
	</script>
</body>
</html>