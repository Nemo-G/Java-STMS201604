	var stompClient = null;
	var newTicketSum = 0;
	$( document ).ready(function() {
	    connect();
	});	
    function connect() {
        var socket = new SockJS('/ws');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function(frame) {
       
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/newticket', function(message){
            	console.log(message);
                showMessage(message.body);              
            });
        });
    }

    function disconnect() {
        if (stompClient != null) {
            stompClient.disconnect();
        }
        console.log("Disconnected");
    }

    function send(message) {
        stompClient.send("/ws", {}, message);
        		//JSON.stringify({ 'name': name })
    }

    function showMessage(message) {
    	console.log("show " + message)
    	var time = new Date();
        //store message to db

        $.ajax({
    		url: '/rest/instantmsg',
    		type: 'POST',
    		contentType: 'application/json',
    		data: JSON.stringify({
    			"createdtime": time.toLocaleString(),
    			"mcontent": message
    		}),
    		error: function() {
    			console.log('Message insert error')
    		},
    		success: function(data){
    			var messageUrl = data._links.self.href
    			var urlList = messageUrl.split('/')
    			var mid = urlList[urlList.length-1]
    			$('#wsResponse').append(
    					"<div id='"+mid+"'>"+
    					"<a href='/ticket/unfinished?key="+message+"' class='list-group-item alert' style='background-color:#fcf8e3' target='blank'>" +
    		    		"<button onclick='readMsg(this)' type='button' class='close' data-dismiss='alert' aria-hidden='true'><span class=' text-muted small'><em> Just Now </em></span>× </button><i class='fa fa-money fa-fw'></i>" +
    		    		" Incoming Ticket - #ID : " + message +
    		    		"</a></div>");
    	        $('#ticketsum').html(++newTicketSum);
    	        $('#nofiticationSum').html(newTicketSum)
    		}
    	});
        
    }
    
    
    
    
 