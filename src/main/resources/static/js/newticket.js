	var menulist={}
	var skillOptions = {}
	//typehead.js for autocomplete
	
	function initAutocomplete(){
		var autofillLocation = new Bloodhound({
		  datumTokenizer: Bloodhound.tokenizers.whitespace,
		  queryTokenizer: Bloodhound.tokenizers.whitespace,
		  prefetch: '/autocomplete?location'
		});
		var autofillName = new Bloodhound({
		  datumTokenizer: Bloodhound.tokenizers.whitespace,
		  queryTokenizer: Bloodhound.tokenizers.whitespace,
		  prefetch: '/autocomplete?name'
		});
	
		var autofillPhone = new Bloodhound({
		  datumTokenizer: Bloodhound.tokenizers.whitespace,
		  queryTokenizer: Bloodhound.tokenizers.whitespace,
		  prefetch: '/autocomplete?phone'
		});
		// passing in `null` for the `options` arguments will result in the default
		// options being used
		$('[name=location]').typeahead(null, {
		  name: 'location',
		  source: autofillLocation,
		  limit:10
		});
		
		$('[name=consumerName]').typeahead(null, {
			  name: 'Name',
			  source: autofillName,
			  limit:10
			});
		
		$('[name=consumerPhone]').typeahead(null, {
			  name: 'Phone',
			  source: autofillPhone,
			  limit:10
			});
	}
	
	function destroyAutocomplete(){
		localStorage.removeItem("__/autocomplete?location__data")
		localStorage.removeItem("__/autocomplete?name__data")
		localStorage.removeItem("__/autocomplete?phone__data")
		initAutocomplete()
	}
		
		function ajaxOptions(){
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
		    	 
		    	 $(skillOptions).each(function(index,value){
	 					menulist[value.Value]=value.DisplayText;
	 					$('#problem-type').append(" <div class='radio'>" +
	 							"<label><input type='radio' name='problemtype' value='" +
	 							value.Value +"' required>" + value.DisplayText +
	 							"</label></div>");
	 				});

		      }				      
		   });
		};
		
		
 	
		$('.submit').click(function(e){
			e.preventDefault();
			$('#reportForm').validator('validate')
			if($('.list-unstyled').length===0){
				var formData={}
				$($('#reportForm')).find("input[name]").not('.tt-hint').each(function (index, node) {
			        formData[node.name]=node.value 
			    });
				
				 $($('#reportForm')).find("input[name='problemtype']").each(function (index, node) {
				    if(node.checked) formData[node.name]=node.value 
				 });
				 //console.log(formData)
				 var date = new Date();
				 formData["details"]=document.getElementsByName('details')[0].value;
				 formData["createdTime"]=date.toLocaleString();
				 formData["tid"]=formData["consumerName"]+date.getTime();
				 formData["statusId"] = 0
				 $.ajax({
				      url: '/rest/tickets',
				      type: 'POST',
				      contentType: 'application/json',
				      data: JSON.stringify(formData),
				      error: function() {
				         $('#info').html('<p font={color:red}>An error has occurred</p>');
				      },
				      dataType: 'json',
				      success: function(data) {
				    	 document.getElementById("reportForm").reset();
				         //console.log(data);
				         $('#dismiss-submit').click();
				      }				      
				   });
			}
				
		

			
			//ajax submit form
			
				
		
			
			
			//

		})  
