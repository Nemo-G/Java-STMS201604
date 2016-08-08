import React from 'react';
import CardMDL from './CardMDL'
import Update from 'react-addons-update';
import Divider from 'material-ui/Divider';
import Checkbox from 'material-ui/Checkbox';
import TextField from 'material-ui/TextField';
import MenuItem from 'material-ui/MenuItem';
import AutoComplete from 'material-ui/AutoComplete';
import RaisedButton from 'material-ui/RaisedButton';
import FlatButton from 'material-ui/FlatButton';
import DatePicker from 'material-ui/DatePicker';
import SelectField  from 'material-ui/SelectField';
import CircularProgress from 'material-ui/CircularProgress';
import { Step, Stepper, StepLabel } from 'material-ui/Stepper';
import {Card, CardActions, CardHeader, CardText} from 'material-ui/Card';

const hostPrefix = (process.env.NODE_ENV === "development")?"http://localhost:8080":""

class ProblemReport extends React.Component{
	constructor(props) {
		super(props)
		this.state = 
		{
		    name: "",
		    location:"",
		    phone: "",
		    problemtype:"",
		    details:"",    
		    expectedDate:"",
		    default:{
		    	problemtypeList : [],
		    	post:"",
		    	searchResult: "",
		    	init:true,
		    	loading: false,
		    	save:false,
		    	ticket:""
		    }

	    };

		//problemtypeList = [{text:"Not loaded",value:"Not loaded"}]
       
	}
	
	updateDefaultNested = (key,value) => {
    	this.setState({
			default: Update(this.state.default, {[key]:{$set: value}})
	    })

    }

	componentWillMount = () => {
         // this.refs.name.getDOMNode().focus(); 
        
        let xhr = new XMLHttpRequest(); 
 		xhr.onreadystatechange = () =>{ 
 			if (xhr.readyState === 4)
 				if (xhr.status === 200) {
	 				const menulist = JSON.parse(xhr.responseText)._embedded.skillconfig.map(
				        (skill)=>new Object({text:skill.skilldetail,value:skill.skillId}));
	 				;   			
	 				//console.log(this.state.problemtypeList)
	 				this.updateDefaultNested("problemtypeList",menulist)
	 				//console.log(this.state.default.searchResult.length)
	 			}else
	 				alert('Cannot connecting to server!')
 			
  		}
  		xhr.open("GET", hostPrefix+"/rest/skillconfig/");
		xhr.send();
    }

	handleClick = (event) => {
  	  	event.preventDefault()
  	  	//deep copy using JSON trick
  	    let data = JSON.stringify(this.state)
  		data = JSON.parse(data); 		
  		this.updateDefaultNested('init',false)
  	  	for (let key in data)
  	  		if (key !== "default" && data[key]==='') {
  	  			if (this.refs[key] && this.refs[key].focus) 
  	  				this.refs[key].focus()
  	  			return false;
  	  	}

  	  	//localStorage
  	  	console.log(this.state.default.save)
  	  	if (this.state.default.save){
  	  		let nameList=[], locList=[], phoneList=[]
  	  		if(typeof localStorage.name !== 'undefined'){
  	  			nameList = JSON.parse(localStorage.name)
  	  			locList = JSON.parse(localStorage.location)
  	  			phoneList = JSON.parse(localStorage.phone)
  	  		}
  	  		console.log(nameList,locList,)
  	  		nameList.push(this.state.name)
  			locList.push(this.state.location)
  			phoneList.push(this.state.phone)
  	  		localStorage.setItem("name",JSON.stringify(nameList))
  	  		localStorage.setItem("location",JSON.stringify(locList))
  	  		localStorage.setItem("phone",JSON.stringify(phoneList))
  	  	}
  	  	// ajax post here 
  	  	let xhr = new XMLHttpRequest(); 
  		let date = new Date();
		data["createdTime"]=date.toLocaleString();
		data["tid"]=data["name"]+date.getTime();
		data["consumerName"] = data["name"]
		data["consumerPhone"] = data["phone"]
		data["expectedDate"] = this.state.expectedDate.toISOString().slice(0,10)

		xhr.onreadystatechange = () =>{ 
			if (xhr.status === 500)
				this.updateDefaultNested("post","Submit error")
			//A status code 201 used by spring-data-rest meaning CREATED
 			if (xhr.readyState === 4 && xhr.status === 201) {
 				//console.log(JSON.stringify(data))
 				this.updateDefaultNested("loading",false);
 				this.updateDefaultNested("post","Submit Success with Ticket ID: "+data.tid)
 			}
  		};

  		xhr.onerror = ()=>{ this.updateDefaultNested("post","Submit error")}
  	  	
  	  	xhr.open("POST", hostPrefix+"/rest/tickets");
  	  	this.updateDefaultNested("loading",true)
		xhr.setRequestHeader("Content-Type", "application/json");
		xhr.send(JSON.stringify(data));

  	  	
  	  	
  	}
    
    handleReset = () =>{
    	//the Update add-on can only be called once!    	
    	this.setState({
    		default: Update(this.state.default, {save:{$set: false},
												 post:{$set: ""},
												 loading:{$set: false},
												 searchResult:{$set: ""},
												 ticket:{$set: ""} 
					 })
    	})
    	
    	this.setState({
			name: "",
		    location:"",
		    phone: "",
		    problemtype:"",
		    details:"",    
		    expectedDate:""
		})
    	console.log(this.state.default)
    }

  	handleChange = (event) => {
  		event.preventDefault();
  		this.setState({details:event.target.value});
  	}

  	searchticket = () => {
  		if(this.state.default.ticket===""){
  			this.refs.ticket.focus()
  			this.updateDefaultNested("searchResult","")
  		}
  		else{
  			let xhr = new XMLHttpRequest(); 
	 		xhr.onreadystatechange = () =>{ 
	 			if (xhr.readyState === 4)
	 				if (xhr.status === 200) {
		 				let ticket = JSON.parse(xhr.responseText)
		 				if (localStorage.getItem("search")===null){
		 					localStorage.setItem("search",JSON.stringify([ticket.tid]))
		 				}else if (localStorage.search.indexOf(ticket.tid)===-1){
		 					let searchHistory = JSON.parse(localStorage.search)
		 					searchHistory.push(ticket.tid)
		 					localStorage.search = JSON.stringify(searchHistory)
		 				}
		 				
		 				//console.log(ticket)
		 				this.updateDefaultNested("searchResult",ticket.statusId)
		 			}else
		 				this.updateDefaultNested("searchResult","Ticket Not Found")
	 			
	  		}

	  		xhr.open("GET", hostPrefix+"/rest/tickets/"+ this.state.default.ticket);
			xhr.send();
  		}
  	}

  	autoFillByName = (text,index) =>{
  		this.setState({
  			name:text,
  			location:JSON.parse(localStorage.location)[index],
  			phone:JSON.parse(localStorage.phone)[index]})
    	this.updateDefaultNested("save",false)

  	}

	render(){
		const {init} = this.state.default
		const statusList = ["Unchecked",
		 						"Assigning Worker","Worker Accepted",
		 						"Problem Handling","Ticket Finished"]
		const {searchResult} = this.state.default
		return (			
			<div className="mdl-grid ">
				<CardMDL 
		          title = "Basic Information"
		          width = "mdl-cell--3-col"
		        >
					<h5>Please input your basic information</h5>
					
					{/*<TextField	     
				      floatingLabelText="Reporter Name"	   
				      fullWidth={true}   
				      ref="name"
				      onChange={(e)=>this.setState({name:e.target.value})}
				      value={this.state.name}
				      errorText={!(/^[A-z]{4,}$/.test(this.state.name)) && "This field is invalid, must be more than 4 characters"}
				    />*/}
				    <AutoComplete
	                  floatingLabelText="Name"
	                  fullWidth={true}
	                  filter={AutoComplete.noFilter}
	                  openOnFocus={true}
	                  ref="name"
	                  searchText={this.state.name}
	                  onNewRequest={this.autoFillByName}
	                  onKeyUp={(e) => this.setState({name:e.target.value})}
	                  errorText={!(/^[A-z]{4,}$/.test(this.state.name)) && "This field is invalid, must be more than 4 characters"}
	                  dataSource={(typeof localStorage.name ==='undefined')?[]:JSON.parse(localStorage.name)}
	                />
				   				   
				    <TextField			      
				      floatingLabelText="Location"
				      fullWidth={true}
				      ref="location"
				      onChange={(e)=>this.setState({location:e.target.value})}
				      value={this.state.location}
				      errorText={this.state.location==="" && "This field is required"}
				    />

				    <TextField			    
				      floatingLabelText="Phone number"
				      fullWidth={true}	
					  ref="phone"
					  onChange={(e)=>this.setState({phone:e.target.value})}
				      value={this.state.phone}
				      errorText={!(/^[0-9]{8,}$/.test(this.state.phone)) && "This field is required, must be more than 8 numbers"}		     
				    />		
				    <br/>
				    <Checkbox
				      style={{minWidth:380}}
				      ref='localSave'
				      checked={this.state.default.save}
				      label="Save my information on this computer"
				      labelPosition="left"
				      onCheck={(e) => this.updateDefaultNested("save",e.target.checked)}
					/>

				</CardMDL>

				<CardMDL 
		          title = "Problem Details"
		          width = "mdl-cell--3-col"
		        >
		        	<h5>Please describe your problem</h5>
		        	<br/>
		        	<SelectField
				    	hintText="Choose problem type"
				    	ref="problemtype"
				    	fullWidth={true}	
				        value={this.state.problemtype}
				        errorText={!init && this.state.problemtype==="" && "This field is required"}
				        onChange={(event, index, value) => this.setState({problemtype:value})}
					        >
				        {this.state.default.problemtypeList.map((item)=>{
				          	return <MenuItem key={item.text} value={item.value} primaryText={item.text}/>})}
				    </SelectField>

		        	<TextField
						hintText="Please describe your problem"
						floatingLabelText="Please describe your problem"
						fullWidth={true}
						value = {this.state.details}
						onChange = {this.handleChange}
						multiLine={true}
						rows={2}
						ref="details"
						onChange={(event, value) => this.setState({details:value})}
						errorText={!init && this.state.details==="" && "This field is required"}
					/>	
						    
				    <DatePicker 
						hintText="Available Date" 
						ref="expectedDate"
						fullWidth={true}	
						value={this.state.expectedDate}
						onChange={(event, value) => this.setState({expectedDate:value})}
						autoOk={true}
				    />
					<p>Our worker will contact you for the exact time available.</p>
					<br/>

			    	<RaisedButton 
			    	 	className="mdl-cell--6-col"
			    	 	//fullWidth={true}
			    		label="Submit" 
			    		style={{ margin: 12}}
			    		secondary={true} 
			    		onClick={this.handleClick} 
			    	 />
			    	 <RaisedButton 
			    	 	className="mdl-cell--5-col"
			    		label="Reset" 
			    		style={{ margin: 12}}
			    		onClick={this.handleReset} 
			    	 />
			    				    	
				</CardMDL>
					
			    <CardMDL 
		          title = "Ticket Searching"
		          width = "mdl-cell--3-col"
		        >
						<h5>Input your Ticket ID to check its status</h5>
						
						
						{this.state.default.loading?
							(<div><CircularProgress /><h4> Submitting...</h4></div>):
							(<h4>{this.state.default.post}</h4>)
						}
						<AutoComplete			      
					      floatingLabelText="Please Input Your Ticket ID"
					      ref="ticket"
					      filter={AutoComplete.noFilter}
					      openOnFocus={true}
					      onNewRequest={(text)=>this.updateDefaultNested("ticket",text)}
					      onKeyUp={(e)=>this.updateDefaultNested("ticket",e.target.value)}
					      searchText={this.state.default.ticket}	
					      dataSource={(typeof localStorage.search ==='undefined')?[]:JSON.parse(localStorage.search)}
					    />

					    <FlatButton 
					    	style={{marginLeft: 12}}
					    	primary={true}
					    	label="Search" 
					    	onClick={this.searchticket}
			    	 	/>
			    	 	{searchResult !=='' &&
						<Card>
					    	<Stepper activeStep={parseInt(searchResult)} orientation="vertical">
					    		
					    		{statusList.map((statusName)=>{
					    			return (<Step key={statusName}>
					            				<StepLabel>{statusName}</StepLabel>
					          			    </Step>)
					    		})}
					        </Stepper>
						    
						</Card>
						}
						
				</CardMDL>
			</div>
			
		)
	}
}

export default ProblemReport;