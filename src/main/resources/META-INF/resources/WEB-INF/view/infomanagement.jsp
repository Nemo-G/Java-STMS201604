<!DOCTYPE html>
<html>
<head>
<title>Welcome</title>
<!-- <meta name="_csrf" content="${_csrf.token}" /-->
<!-- default header name is X-CSRF-TOKEN -->
<!-- meta name="_csrf_header" content="${_csrf.headerName}" /> -->
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
<link rel="stylesheet"
	href="/webjars/jquery-ui/1.10.4/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="/webjars/jTable/2.4.0/themes/metro/lightgray/jtable.css">
<link rel="stylesheet"
	href="css/validationEngine.jquery.css">
<body>
	<div id='wrapper'>
		<%@ include file="template/nav-head.jsp"%>
		<div id="page-wrapper">
			<div class="container-fluid">
				<div class="col-lg-10">
				
					<h1 class="page-header">Employee Information</h1>
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
							<button type="button"
									class="btn btn-outline btn-danger"
									style="float: right"
									data-toggle="modal" data-target="#myModal">Delete Selected Rows
							</button>
							<button class="btn btn-outline btn-primary" style="float: right" onclick="$('.jtable-toolbar-item-add-record').click()">Add New Employee</button>      
								<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
									aria-labelledby="myModalLabel" aria-hidden="true"
									style="display: none;">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal"
													aria-hidden="true"><i class="fa fa-fw fa-minus-circle"></i></button>
												<h4 class="modal-title" id="myModalLabel">Warnings</h4>
											</div>
											<div class="modal-body">Are you sure to delete selected records?</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default"
													data-dismiss="modal">Cancel</button>
												<button type="button" id="deleteSelected"
													data-dismiss="modal">Confirm</button>
											</div>
										</div>
										<!-- /.modal-content -->
									</div>
									<!-- /.modal-dialog -->
								</div>
						</div>
										
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div id="inviTable" class="panel panel-primary"></div>
					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->
				</div>
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
	<script src="/webjars/jquery-ui/1.10.4/ui/jquery-ui.js"></script>
	<script src="/webjars/jTable/2.4.0/jquery.jtable.js"></script>
    <script src="js/jquery.validationEngine-en.js"></script>
    <script src="js/jquery.validationEngine.js"></script>
    <script src="js/tablesorter.js"></script>
    <script src="js/worker-client.js"></script>
	<script>



$(document).ready(function () {
	
	
	var skillOptions = {}
	$.ajax({
	      url: '/rest/skillconfig/',
	      type: 'GET',
	      error: function() {
	         console.log('getSkillOption Error')
	      },
	      dataType: 'json',
	      success: function(data) {
	    	 //console.log(data)
	    	 skillOptions = data._embedded.skillconfig.map(
				        (skill)=>new Object(
				        		{
				        			DisplayText:skill.skillname,
				        			Value:skill._links.self.href.split('/').pop()
				        			})); 
	    	// console.log(skillOptions)
	      }				      
	   });
	
	var diplomaOptions = [
	{DisplayText: 'Middle School',Value:'Middle School'},
	{DisplayText: 'High School',Value:'High School'},
	{DisplayText: 'College',Value:'College'},
	{DisplayText: 'Other',Value:'Other'}      	
    	]
    $('#inviTable').jtable({
        title: 'Information',
        selecting: true, //Enable selecting
        multiselect: true, //Allow multiple selecting
        selectingCheckboxes: true, //Show checkboxes on first column
        /* paging: true,
        pageSize: 10,
        sorting: true,
        defaultSorting: 'uid ASC', */
        
        actions: {
            listAction: '/allemployees?action=list',
            createAction: '/allemployees?action=create',
            updateAction: '/allemployees?action=update',
            deleteAction: '/allemployees?action=delete'
        },
        fields: {
            eid: {
                key: true,
                title: 'ID',
                edit: false,
                create: false,
                width: '5%',
                inputClass: 'validate[required,custom[integer]]'
            },
            name: {
                title: 'Name',
                width: '5%',
                inputClass: 'validate[required]'
            },
            diploma: {
                title: 'Diploma',
                sorting: false,
                width: '7%',
                options: diplomaOptions,
                inputClass: 'validate[required]'
            },
            phone: {
            	width: '7%',
                title: 'Phone'
            },
            gender: {
                title: 'Gender',
                width: '5%',
                type: 'radiobutton',
                options: { 'm': 'Male', 'f': 'Female' },
                defaultValue: 'm'
            },
            age: {
                title: 'Age',
                width: '5%',
                inputClass: 'validate[required]'
            },
            checked: {
                title: 'Checked',
                width: '5%',
                type: 'checkbox',
                values: { 'false': 'NOT', 'true': 'Checked' },
                defaultValue: 'false'
            },
            employed: {
                title: 'Employed',
                width: '5%',
                type: 'checkbox',
                values: { 'false': 'NOT', 'true': 'Employed' },
                defaultValue: 'false'
            },
            online:{
            	title: 'Online',
                width: '5%',
                type: 'checkbox',
                values: { 'false': 'Offline', 'true': 'Online' },
                defaultValue: 'false'
            },
            bankaccount: {
            	width: '8%',
                title: 'BankAccount'
            },
            skilltable:{
                title: 'Skill Pool',
                width: '5%',
                sorting: false,
                edit: false,
                create: false,
                display: function (data) {
                    //Create an image that will be used to open child table
                    var $img = $("<div><i class='fa fa-fw fa-tasks'></i> Details<span class='fa arrow'></span></div>");
                    //Open child table when user clicks the image
                    $img.click(function () {
                        $('#inviTable').jtable('openChildTable',
                                $img.closest('tr'), //Parent row
                                {
                                title: 'Employee ID:'+data.record.eid + ' - Skill Pool',
                                actions: {
                                    listAction: '/skill?action=list&employeeId=' + data.record.eid,
                                    deleteAction: '/skill?action=delete&employeeId=' + data.record.eid,
                                    updateAction: '/skill?action=update&employeeId=' + data.record.eid,
                                    createAction: '/skill?action=create&employeeId=' + data.record.eid,
                                },
                                fields: {
                                    sid: {
                                    	key: true,
                                    	title: '#ID',
                                    	width: '5%',
                                    	sorting: false,
                                        edit: false,
                                        create: false,
                                        type: 'hidden'
                                    },
                                    skillId:{
                                    	title: 'Skill Name',
                                    	display: function(data){
                                    		//console.log(data);
                                    		return data.record.skillset.skillname
                                    	},
                                    	options: skillOptions
                                   },
                                   skillDetail:{
                                   	title: 'Skill Detail',
                                   	edit: false,
                                    create: false,
                                   	display: function(data){
                                   		return data.record.skillset.skilldetail
                                   	}
                                   }
                                }
                            }, function (data) { //opened handler
                                data.childTable.jtable('load');
                            });
                    });
                    //Return image to show on the person row
                    return $img;
                }
            }
        },
       //Initialize validation logic when a form is created
        formCreated: function (event, data) {
            data.form.validationEngine();
        },
        //Validate form when it is being submitted
        formSubmitting: function (event, data) {
            return data.form.validationEngine('validate');
        },
        //Dispose validation logic when form is closed
        formClosed: function (event, data) {
            data.form.validationEngine('hide');
            data.form.validationEngine('detach');
        }
    });
    
    
	$('#filter').keyup(function(e){
		  //console.log(e.target.value)
	      $.each($("#inviTable").find(".jtable-data-row"), function() {
	        if($(this).text().toLowerCase().indexOf(e.target.value.toLowerCase()) === -1)
	           $(this).hide();
	        else
	             $(this).show();                
	      });
	    }
	);

    //Load all records when page is first shown
    $('#inviTable').jtable('load',{},function(){
    	new TableSorter($(".jtable")[0]);
    });
    
    //Delete selected rows
    $('#deleteSelected').button().click(function () {
        var $selectedRows = $('#inviTable').jtable('selectedRows');
        $('#inviTable').jtable('deleteRows', $selectedRows);
    });
    
});
</script>
</body>
</html>