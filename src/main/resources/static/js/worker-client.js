if (!!window.SharedWorker) {
		//console.log('Support')
		var myWorker = new SharedWorker('/js/worker.js','Stomp-SockJS');
		var newticket = 0
		console.log(myWorker)
		//myWorker.port.start()
		myWorker.onerror = function(e){
			console.log(e)
		}
		myWorker.port.onmessage = function(e) {
		    //console.log(e.data);
//			var messageBody = JSON.parse(e.data.res);
//			//console.log(e.data);
//			$('#head-message').append(
//					"<div id='"+e.data.tid+"'>"+
//					"<li>"+
//					"<a href='/ticket/unfinished?key="+messageBody.mcontent+"' class='list-group-item alert'>"+ 
//					"<button onclick='readMsg(this)' type='button' class='close' data-dismiss='alert' aria-hidden='true'> × </button>"+
//					"<i class='fa fa-money fa-fw'> </i> Receive a ticket just now..." +
//					
//					"</a></li><li class='divider'></li></div>")
			
			var tid = e.data;
			var date = new Date()
			$('#head-message').append("<li>"+
					"<a href='/ticket/unfinished?key="+tid+"' class='list-group-item alert'>"+ 
					"<i class='fa fa-money fa-fw'> </i>New Ticket Received!<br/>#"+tid + " @"+date.toLocaleTimeString()+					
					"</a></li>")
			
			$('#notificationSum').html(++newticket);
		
		}
	}
