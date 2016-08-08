<!DOCTYPE html>
<html>
<head>
<title>Welcome</title>

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
	href="/webjars/jTable/2.4.0/themes/metro/darkgray/jtable.css">
<link rel="stylesheet"
	href="/css/validationEngine.jquery.css">
<link rel="stylesheet"
	href="/css/typehead.css">
<body>
	<div id='wrapper'>
		<%@ include file="template/nav-head.jsp"%>
		<div id="page-wrapper">
			<div class="container-fluid">
				<div class="col-lg-10">
					<h1 class="page-header">All Tracking Tickets</h1>
				
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
									data-toggle="modal" data-target="#myModal1">Delete Selected Rows
							</button>  
            	<button class="btn btn-outline btn-primary" data-toggle="modal" style="float: right" data-target="#myModal">Start a Ticket</button>
            	 
            	                
            </div>
            </div>
				<div class="row">
					<div class="col-lg-12">

						
                            
                                      							
								<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
									aria-labelledby="myModalLabel" aria-hidden="true"
									style="display: none;">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal"
													aria-hidden="true"><i class="fa fa-fw fa-minus-circle"></i></button>
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
                          
								<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
									aria-labelledby="myModalLabel" aria-hidden="true"
									style="display: none;">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal"
													aria-hidden="true"><i class="fa fa-fw fa-minus-circle"></i></button>
												<h4 class="modal-title" id="myModalLabel">Warings</h4>
											</div>
											<div class="modal-body">Are you sure to delete all selected records?</div>
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
				<div id="examTable" class="panel panel-primary"></div>

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
	<script src="/js/typehead.js"></script>
    <script src="/js/jquery.validationEngine-en.js"></script>
    <script src="/js/jquery.validationEngine.js"></script>
	<script src="/js/validation.js"></script>
	<script src="/js/newticket.js"></script>
	<script src="/js/tablesorter.js"></script>
	<script src="/webjars/jTable/2.4.0/jquery.jtable.js"></script>
	
	<script src="/js/worker-client.js"></script>
	<script>


$(document).ready(function () {
	//This is a proof that localStorage can be shared cross page
	//console.log(localStorage.getItem("a"))
	ajaxOptions();
	
	$('#filter').keyup(function(e){
		  //console.log(e.target.value)
	      $.each($("#examTable").find(".jtable-data-row"), function() {
	        if($(this).text().toLowerCase().indexOf(e.target.value.toLowerCase()) === -1)
	           $(this).hide();
	        else
	             $(this).show();                
	      });
	    }
	);	

    $('#examTable').jtable({
        title: 'Tickets',
        selecting: true, //Enable selecting
        multiselect: true, //Allow multiple selecting
        selectingCheckboxes: true, //Show checkboxes on first column
        /* sorting: true,
        defaultSorting: 'id ASC', */
        actions: {
            listAction: '/ticketstable?action=list',
            //createAction: '/ticketstable?action=create',
            updateAction: '/ticketstable?action=update',
            deleteAction: '/ticketstable?action=delete'
        },
        fields: {
            tid: {
                key: true,
                title: 'Ticket ID',
                edit: false,
                create: false,
                list: true
            },
            consumerName: {
                title: 'Customer',
                width: '10%'
            },
            consumerPhone:{
            	title: 'Contact'
            },
           
            createdTime: {
                title: 'Created Time',
                width: '10%'
            },
            
            location: {
                title: 'Location',
                type: 'textarea',
                list: false
            },
            problemtype:{
            	title: 'Problem Type',
            	edit:true,
            	display: function(data){
            		//console.log(data);
            		return menulist[data.record.problemtype]
            	},
                options: function(data){
                	//should be a callback ,otherwise skillOptions will be null because table is initialized before ajaxOptions() call
                	console.log(skillOptions)
                	return skillOptions;
                }

            },
            statusId: {
                title: 'Ticket Status',
                options: { '0': 'Unchecked', 
                		   '1':'Assigning Worker','2':'Worker Accepted','3':'Ticket Printed','4':'Finished',
                		   '5': 'Closed','6':'Failed' }               
            },
            details:{
                title: 'Details',
                type: 'textarea',
                list: false
            },
            fee: {
            	width: '5%',
                title: 'Ticket Fee',
                inputClass: 'validate[required,custom[integer]]'
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
    
    //Load all records when page is first shown
   
	 $('#examTable').jtable('load',{},function(){
		 new TableSorter($(".jtable")[0]);
		 //$('.jtable').tablesorter()
	 });
    	
    
    $('#deleteSelected').button().click(function () {
        var $selectedRows = $('#examTable').jtable('selectedRows');
        $('#examTable').jtable('deleteRows', $selectedRows);
    });
    
    
    

});
</script>
</body>
</html>