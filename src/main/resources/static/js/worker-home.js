var newTicketSum = 0

if (!!window.SharedWorker) {
		//console.log('Support')
		var myWorker = new SharedWorker('/js/worker.js','Stomp-SockJS-Home');
		var newticket = 0
		console.log(myWorker)
		//myWorker.port.start()
		myWorker.onerror = function(e){
			console.log(e)
		}
		myWorker.port.onmessage = function(e) {
		    //console.log(e.data);
/*			var messageBody = JSON.parse(e.data.res);
			//console.log(e.data);
			$('#head-message').append(
					"<div id='"+e.data.tid+"'>"+
					"<li>"+
					"<a href='/ticket/unfinished?key="+messageBody.mcontent+"' class='list-group-item alert'>"+ 
					"<i class='fa fa-money fa-fw'> </i> Receive a ticket just now..." +
					"</a></li><li class='divider'></li></div>")
			$('#notificationSum').html(++newticket);*/
			var tid = e.data;
			console.log(tid)
			$('#head-message').append("<li>"+
					"<a href='/ticket/unfinished?key="+tid+"' class='list-group-item alert'>"+ 
					"<i class='fa fa-money fa-fw'> </i> Receive a ticket just now..." +					
					"</a></li>")
			
			if(window.location.pathname==='/welcome'){
				$('#wsResponse').append(
						"<a href='#' class='list-group-item alert' style='background-color:#fcf8e3' >" +
			    		"<span class='pull-right text-muted small'><em> Just Now </em></span>" +
			    		"<div data-toggle='modal' data-target='#myModal' onclick=\"process('"+tid+"')\">"+
			    		"<i class='fa fa-money fa-fw'></i>" +
			    		" Incoming Ticket - #ID : " + tid +
			    		"</div></a>");
			    $('#ticketsum').html(++newTicketSum);
			}
				//showMessageList(messageBody)
		}
	}

function showMessageList(data){
	var mid = data.mid
	var message = data.mcontent
	$('#wsResponse').append(
			"<div id='"+mid+"'>"+
			"<a href='#' class='list-group-item alert' style='background-color:#fcf8e3' >" +
    		"<button onclick='readMsg(this)' type='button' class='close' data-dismiss='alert' aria-hidden='true'><span class=' text-muted small'><em> Just Now </em></span>× </button>" +
    		"<div data-toggle='modal' data-target='#myModal' onclick=\"process('"+message+"')\">"+
    		"<i class='fa fa-money fa-fw'></i>" +
    		" Incoming Ticket - #ID : " + message +
    		"</div></a></div>");
    $('#ticketsum').html(++newTicketSum);
    $('#nofiticationSum').html(newTicketSum)
}