<div class="panel panel-primary">
	<div class="panel-body">

   

   <div class="row">
        <div class="col-lg-12">
        <form id="reportForm" role="form" >
         <div class="form-group"> 
            <label>Name</label>
            <br/>
            <input placeholder="Customer Name" 
                   class="typeahead form-control" name="consumerName" 
                   pattern="^[A-z]{4,}$"
                   data-minlength="4"
                   required 
                   data-error="Name field is invalid! Must be longer than 4 characters" />
            <div class="help-block with-errors"></div>
        </div>        
         <div class="form-group  has-feedback">
             <label>Phone</label><br/>
             <input placeholder="Customer Phone"	
               	   class="form-control typeahead" name="consumerPhone" 
               	   data-minlength="8" required 
            	   pattern="^[0-9]+(-[0-9]+)*$" 
            	   data-error="Phone number is invalid! Must be longer than 8 numbers" />
             <div class="help-block with-errors"></div>
         </div>
         <div class="form-group  has-feedback"> 
           <label>Place</label><br/>
           <input placeholder="Customer location"
            	class="form-control typeahead" name="location" required data-error="Place must be specified!">
           <div class="help-block with-errors"></div>
         </div>
         
         
 		 
         <div class="form-group" > 
            <label>Problem Type</label>
            <div id="problem-type"></div>
             
            <div class="help-block with-errors"></div>            
         </div>
        
         <div class="form-group has-feedback"> 
           <label>Problem Details</label>
           <textarea placeholder="Please input the details of problem"
            	class="form-control " required data-error="Please specify your problems!" name="details" rows="5" maxlength="255"
            	></textarea>
           <div class="help-block with-errors"></div> 
         
        </div>  
        <p style="color:red" id='info'></p>
        <div class="form-group" > 
         <button class="btn btn-outline btn-primary" type="reset" style="float: right" onclick="destroyAutocomplete()"> Reset </button>
         <button class="btn btn-outline btn-success submit" style="float: right" onclick="destroyAutocomplete()">
          	Submit
        </button>
        </div>
        </form>
      </div>
   </div>
      
          
      
        
   


       

        
      
  

 
	</div>
</div>
