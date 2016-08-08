importScripts('sockjs1.1.0.min.js')
importScripts('stomp2.3.3.js');

var workerSelf = self
onconnect = function(e) {
	port = e.ports[0];
	//console.log(workerSelf.stompClient)
	//port.start()
	port.addEventListener('message', function(e) {
       console.log(e)
    });
	//port.postMessage('Shared Worker Connected')
	if (typeof workerSelf.stompClient === 'undefined'){
		console.log('connect STOMP')
		//port.postMessage({type:'connect',content:'worker connect--sockjs connect'})
		connect();
	}
		
	
}



function connect() {
    var socket = new SockJS('/ws');
    workerSelf.stompClient = Stomp.over(socket);
    workerSelf.stompClient.connect({}, function(frame) {
    	workerSelf.stompClient.subscribe('/topic/newticket', function(message){
            //showMessage(message.body);
    		port.postMessage(message.body)
        });
    });
}

function showMessage(message) {
	var time = new Date();
    //store message to db
	var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function(){
		if(xhr.readyState ===4 && xhr.status === 201)
			port.postMessage({tid:message,res:xhr.responseText})
	}
	xhr.open("POST",'/rest/instantmsg');
	xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	xhr.send(JSON.stringify({
			"createdtime": time.toLocaleString(),
			"mcontent": message
		}));
	
//    $.ajax({
//		url: '/rest/instantmsg',
//		type: 'POST',
//		contentType: 'application/json',
//		data: JSON.stringify({
//			"createdtime": time.toLocaleString(),
//			"mcontent": msg
//		}),
//		error: function() {
//			console.log('Message insert error')
//		},
//		success: function(data){
//			port.postMessage(data)
//		}
//	});
}