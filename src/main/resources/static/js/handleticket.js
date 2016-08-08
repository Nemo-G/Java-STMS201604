    
	var Status = -1;
	
	function updateStatus(status){
    	var tid = document.getElementById('tid').value
    	if (Status!==status){
    		Status = status
    		
			$.ajax({
		   		url: '/rest/tickets/'+tid,
		   		type: 'PATCH',
		   		error: function() {
		   			alert('Update Ticket Status Error',status)
		   		},
		   		contentType: 'application/json',
		   		data: JSON.stringify({statusId:status})
		   });
    	}
    }
    
    function forceAccept(){
    	var tid = document.getElementById('tid').value
    	//force update worker status
    	$.ajax({
	   		url: '/forceUpdateWorkerStatus?tid='+tid,
	   		type: 'GET',
	   		error: function(){alert('Update Error')},
	   		beforeSend: function(){
	   			$('#pendingAC').html('Update Worker Status...')
	   		},
	   		success: function(data) {
	   			//console.log(data)
	   			$('#pendingAC').html('')
	   	        if (data==='OK'){
	   	           if (Status!==2) {
	   	        	   updateStatus(2)
	   	        	   Status = 2
	   	           }
	   	           process(tid)
	   	        }else{
	   	        	alert('Update Worker Status Error');
	   	        }
	   	        
	   	      }
	   }); 			
    }
    
    function updateTicketStatus(){
    	
    	$.ajax({
	   		url: '/updateTicketStatus',
	   		type: 'GET',
	   		error: function(){alert('Update Error')},
	   		success: function(data) {
	   				location.reload()
	   		} 
	   }); 
    }
    
    function processTicket(){
    	Status = -1
    	location.reload()
    		
    			
    }
    
    function processNext(){
    	var tid = document.getElementById('tid').value
    	var nextTid = ''
    		
    	if ($('.'+tid).next().length === 0){
    		alert('This is the last record!')
	    }else if(location.pathname === '/welcome'){
	    	nextTid = $('.'+tid).next()[0].className
	    }else{
	    	nextTid = $('.'+tid).next().find('td')[0].innerHTML    	
	    }
    	
    	if (nextTid!=='') process(nextTid)
    	
    }
    
    function printWindow(){
    	if ($('#acpanel').find('a').length===0){
    		alert('Worker must be assigned!')
			return false;
    	}
    	
    	var list = $('#acpanel').find('a')
    	for (var i=0;i<list.length;i++){
    		var content = list[i]
    		if(content.text.indexOf('false')!==-1){
    			if (!confirm('One or more workers haven\'t accpeted. Print anyway?'))
    				return false;
    			else 
    				break;
    		}
    	}
    	 var newWin=window.open('','Print-Window','width=1000,height=1000');
         var time = new Date()
         var evaluationHTML = ''; 
         $('#evaluation').find('.input-group-addon').map((index,value)=>{
       	  					evaluationHTML+='<p>'+value.innerHTML+'____</p>'
       	  					}) 
     	  newWin.document.write('<html><title>Printed Time : '+time.toLocaleTimeString()+'</title><body>'+
     			  				'<h4>Ticket Information</h4>'+
     			  				$('#TicketDetail').html()+
     			  				"<li><b>Available time(Negotiate with customer): _________________ </b></li><br/>"+
     			  				'******************************************************************************'+
     			  				'<br/><h4>Worker Evaluation</h4>'+
     			  				evaluationHTML+
     			  				'******************************************************************************'+
     			  				
     			  				'<br/><h4>Charing Details(item and related charge)</h4>'+
     			  				'<ol><li></li><li></li><li></li><li></li><li></li></ol>'+    
     			  				'<h4>Fee : __________&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Worker Signature : __________</h4>'+
     			  				'******************************************************************************'+
     			  				'<br/><h4>Any Comment and Advice:</h4><br/><br/><br/><br/><br/><br/><h4>Customer Signiture:</h4>'+
     			  				'<h5>Name : _________</h5><h5>Date : _________<h5>'+
     	  						'</body></html>');
     	  newWin.print()
     	  newWin.close()
    }
    
    function checkNext(){
    	if ($('#acpanel').find('a').length===0){
    		alert('Worker must be assigned!')
			return false;
    	}
    	var list = $('#acpanel').find('a')
    	for (var i=0;i<list.length;i++){
    		var content = list[i]
    		if(content.text.indexOf('false')!==-1){
    			alert('To continue processing, ALL workers must ACCEPT.')
    				return false;
    		}
    	}
    	
    	$('[href=#step3]').tab('show');
    	if(Status!==3){
    		updateStatus(3);
    		Status = 3
    	}
    }
    
    function showSkillList(skillList){
    	$.each(skillList,function(k,v){
			//console.log(k,v)
			$('#problem').append("<option value='" +
						k +"'>" + v +
						"</option>");
		})
		$('.problemtypeId').each(function(_,item){
			var id = $(item).html()
			$(item).html(skillList[id])
		})
    }
    
    $('.ticketRow').dblclick(function(){$(this).find('button').click()})
    
    
    function process(tid){
    	//use elementValue as a temp variable?
    	
    	document.getElementById('tid').value=tid
    	var ticket = {}
    	var employeeList = []
    	var ridList = []
    	//concurrent Ajax call to get ticket detail
    	$.ajax({
    		url: '/rest/tickets/search/findByTid?tid='+tid,
    		type: 'GET',
    		error: function() {
    			console.log("Error Get Ticket Info")
    		},
    		dataType: 'json',
    		success: function(data) {
    		    ticket = data;
    		    Status = ticket.statusId
    		    //console.log(ticket.statusId)
    		    if (ticket.statusId===0){
    		    	$('[href=#step1]').tab('show')
    		    	$('[href=#step2]').click(function(){return false})
    		    	$('[href=#step3]').click(function(){return false})
    		    }
    		    else if (ticket.statusId===2||ticket.statusId===1){
    		    	$('[href=#step2]').tab('show')
    		    	$('[href=#step3]').click(function(){return false})
    		    }
    		    else if (ticket.statusId===3||ticket.statusId===4){
    		    	$('[href=#step3]').tab('show')
    		    }
    		    delete ticket['_links'];   
    		    //console.log(data)
    		    $('#feeval')[0].value=ticket.fee
    		    $('#fee').html('')
    		    $('#problem')[0].value = ticket.problemtype
    		    var detaillist="";
    		    detaillist =  
    		    	"<li><b>Ticket ID : </b>"+data.tid+"</li>"+
    		    	"<li><b>Reporter Name : </b>"+data.consumerName+"</li>"+
    		    	"<li><b>Reporter Phone : </b>"+data.consumerPhone+"</li>"+
    		    	"<li><b>Created Time : </b>"+data.createdTime+"</li>"+
    		    	"<li><b>Location : </b>"+data.location+"</li>"+
    		    	"<li><b>Details : </b>"+data.details+"</li>"
    		    	
    		    $('#TicketDetail').html(detaillist);
    		    selectworker(ticket.problemtype)
    		}				      
    	  })
    	//another ajax call
    	$.ajax({
    		url: '/rest/ticketrecord/search/findByTid?tid='+tid,
    		type: 'GET',
    		error: function() {
    			alert('Get Ticketrecord Error')
    		},
    		dataType: 'json'	      
    	}).then(function(data){
    		//return a list of ticketrecords, each record mapped to an employee
    		var trList = data._embedded.ticketrecord
    		//console.log(data._embedded.ticketrecord);
    		
    		//generate an array of ajax call
    		var ajaxList = trList.map(function(tr){
    			var url = tr._links.employee.href
    			//console.log(tr)
    			return $.get(url,function(data){
    				employeeList.push({rid:tr.rid,accepted:tr.accepted,employee:data,evaluation:tr.evaluation})
    			})
    		})
    		
    		$.when.apply($, ajaxList).then(function() {
    			//console.log(employeeList)
    			
    			if (employeeList.length === 0){
    				$('#WorkerAssigned').html('')
    				$('#acpanel').html('')
    				$('#evaluation').html('')
    			}
    			else {
    				var arrangeinfo="";
    				var acpanel="";
    				var evl = ""
    				$(employeeList).each(function(index,data){
    					var employee = data.employee
    					var rid = data.rid
    					arrangeinfo = arrangeinfo + "<div id='"+rid+"'>"+
    					"<a href='#' class='list-group-item alert'>" +
    		    		"<button onclick='cancel(this)' type='button' class='close deleteall' data-dismiss='alert' aria-hidden='true'>×</button><i class='fa fa-user fa-fw'></i> Employee ID : #"+
    		    		employee.eid + " -Name : "+employee.name+" -Phone : "+employee.phone+"</a>"
    					+"</div>"
    					
    					acpanel = acpanel + "<a href='#' class='list-group-item' style='background-color:"+(data.accepted?"#dff0d8":"#f2dede")+"'><i class='fa fa-user fa-fw'></i> Employee ID : #"+
    		    		employee.eid + " -<b>Name :</b> "+employee.name+" -<b>Phone :</b> "+employee.phone+" -Accepted : "+data.accepted+"</a>"
    		    		
    		    		evl = evl + "<li class='input-group'><span class='input-group-addon' style='width:85%;text-align:left'><i class='fa fa-user fa-fw'></i> Employee ID : #"+
    		    		employee.eid + " - <b>Name :</b> "+employee.name+" -<b>Phone :</b> "+employee.phone+" - <b>Evaluation(1-5) :</b> </span><input type='text' class='form-control' value='"+data.evaluation+"'>"+
    		    		"<span class='input-group-btn'><button class='btn btn-outline btn-success' onclick='save(this,"+rid+")' style='float:right'>Save</button>"+
    		    		"</span></li>"
    				});
    				$('#WorkerAssigned').html(arrangeinfo);
    				$('#acpanel').html(acpanel);
    				$('#evaluation').html(evl);
    			}
    			
    				
    			//check for assigned employees
    		})
    		
    	})
    	
    	
    	
    }
    
    function updateFee(btn){
    	var tid = document.getElementById('tid').value
    	var fee = parseInt($(btn).parent().prev('input').val())
    	$.ajax({
	   		url: '/rest/tickets/'+tid,
	   		type: 'PATCH',
	   		error: function() {
	   			alert('Update Ticket Fee Error')
	   		},
	   		contentType: 'application/json',
	   		data: JSON.stringify({fee:fee}),
	   		success: function(data){
	   			$('#fee').html('Ticket Fee Saved!')
	   		}
	   });
    }
    
 	function save(btn,rid){
    	var evaluation = $(btn).parent().prev('input').val()
    	//post evaluation
    	$.ajax({
	   		url: '/rest/ticketrecord/'+rid,
	   		type: 'PATCH',
	   		error: function() {
	   			alert('Update Evalutaion Error')
	   		},
	   		contentType: 'application/json',
	   		data: JSON.stringify({evaluation:evaluation}),
	   		success: function(data){
	   			alert('Evalutation Updated')
	   		}
	   });
    }
    
 	
    function cancel(btn){
    	var rid = $(btn).parent().parent()[0].id;
    	$('[href=#step2]').click(function(){return false})
    	$('[href=#step3]').click(function(){return false})
    	//console.log(rid);
    	$.ajax({
    		url: '/rest/ticketrecord/'+rid,
    		type: 'DELETE',
    		error: function() {
    			alert('Ticket Delete Error');
    		},
    		success: function(){
    			if (Status!==1){
    				updateStatus(1)
    				Status = 1
    			}
    		}
    	});
    }
    
    function closeTicket(){
    	var tid = document.getElementById('tid').value
    	var fee = $('#feeval').val()
    	if (fee===''){
    		fee = 0
    		$('#fee').html('Fee is set to 0!')
    		$('#feeval')[0].value = 0
    	}
    	
    	if(confirm('Do you want to complete this ticket?')){
    		$.ajax({
    	   		url: '/rest/tickets/'+tid,
    	   		type: 'PATCH',
    	   		error: function() {
    	   			alert('Update Ticket Fee and Status Error')
    	   		},
    	   		contentType: 'application/json',
    	   		data: JSON.stringify({fee:fee,statusId:4}),
    	   		success: function(data){
    	   			$('#finishticket').click()
    	   			//$('#result').html('Ticket is Finished. If you want to process it again, please go to <b>View All Tickets</b>')
    	   		}
    	   });
    		
    	}
    }
    
    
    $('#showastype').change(function(e){
    	location.href='/ticket/unfinished?key='+e.target.value
    })
    
   $('.next').click(function(){
   		if($('#WorkerAssigned').html()==='')
   			alert('You must assign worker to continue.')
   		else{
   			process(document.getElementById('tid').value)
   			//$('[href=#step2]').tab('show');
   		}

	 // return false;
	  
	})

	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
	  
	  //update progress
	  var step = $(e.target).data('step');
	  var percent = (parseInt(step) / 3) * 100;
	  
	  $('.progress-bar').css({width: percent + '%'});
	  $('.progress-bar').text("Step " + step + " of 3");
	  
	  //e.relatedTarget // previous tab
	  
	})
	

    
	function selectworker(value){
	   var skillid = value;
	   $.ajax({
   		url: '/getEmployeeBySkill?skillid='+skillid,
   		type: 'GET',
   		error: function() {
   			alert('Loading Employee List Error')
   		},
   		dataType: 'json',
   		success: function(employeelist) {
   		   
   		   var onlineGroup = ""
   		   var offlineGroup = ""
   		   $(employeelist).each(function(index,employee){
   			   //console.log(employee.is_employed)
   			   var multiselect = ""
   			   if(employee.is_employed){
   			   multiselect = 
   			   "<option value='"+employee.eid+"'>"+
   			   employee.name+" <b>Processing</b>:"+employee.processing+
   			   " <b>Total:</b> "+employee.count+" <b>Evaluation:</b> "+(employee.avgeval===null?"":employee.avgeval)+
   			   "</option>"
   			   }
   			   if (employee.online_status)
   				   onlineGroup = onlineGroup + multiselect
   			   else
   				   offlineGroup = offlineGroup + multiselect

   		   })
   		   
   		   //console.log(multiselect)
   		   $('#worker-list').html('<optgroup label="Online" class="group-1">'+onlineGroup+'</optgroup>'+
   				'<optgroup label="Offline" class="group-2">'+offlineGroup+'</optgroup>');
   		   
   		   var optionList = $('.group-1').find('option')
   		   if (Status===0 && optionList.length!==0){
   			   $('#worker-list')[0].value = optionList[0].value
   			   $('#worker-list')[0].selected='selected'
   			   //console.log($('#worker-list').val())
   			   $('#worker-assign').click()
   		   }
   		   $('#worker-list').multiselect('rebuild');

   		}				      
   	  });
    }
   
   $('#worker-assign').click(function(){
	   $('.deleteall').click()
	   $('#acpanel').html('')
	   if (Status!==1){
			updateStatus(1)
			Status = 1
		}
	   var selected = $('#worker-list').val();
	   if (selected === null) {
		   alert('You have to select 1 worker at least!')
		   return false;
	   }
	   var tid = document.getElementById('tid').value;
	   var recordList = selected.map(
  				(eid)=>new Object({ticket:'/rest/tickets/'+tid,employee:'/rest/employee/'+eid}));
	   //console.log(data)
	   $(recordList).each(function(index,value){
		   console.log(value)
		   $.ajax({
	   		url: '/rest/ticketrecord',
	   		type: 'POST',
	   		error: function() {
	   			alert('Assign Worker Error')
	   		},
	   		contentType: 'application/json',
	   		data: JSON.stringify(value) ,
	   		dataType: 'json',
	   		beforeSend: function(){
	   			$('#pending').html('Adding worker '+(index+1)+' of '+ recordList.length+'...')
	   		},
	   		success: function(dataRecord) {
				//console.log(data)
	   			if (index===recordList.length-1)
	   				$('#pending').html('')
				var rid = dataRecord.rid
				$.get(dataRecord._links.employee.href,function(data){
    				var employee = data;
    				$('#WorkerAssigned').append("<div id='"+rid+"'>"+
					"<a href='#' class='list-group-item alert'>" +
		    		"<button onclick='cancel(this)' type='button' class='close deleteall' data-dismiss='alert' aria-hidden='true'>×</button><i class='fa fa-user fa-fw'></i> Employee ID : #"+
		    		employee.eid + " -Name : "+employee.name+" -Phone : "+employee.phone+"</a>"
					+"</div>")
					$('#acpanel').append("<a href='#' class='list-group-item' style='background-color:"+(dataRecord.accepted?"#dff0d8":"#f2dede")+"'><i class='fa fa-user fa-fw'></i> Employee ID : #"+
		    		employee.eid + " -Name : "+employee.name+" -Phone : "+employee.phone+" -Accepted : "+dataRecord.accepted+"</a>")
    			})
	   		}				      
	   	  });
	   });
   });
   
   