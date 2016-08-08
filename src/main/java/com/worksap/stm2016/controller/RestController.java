package com.worksap.stm2016.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.Writer;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.reflect.TypeToken;
import com.worksap.stm2016.model.Employeelist;
import com.worksap.stm2016.model.EmployeelistRepository;
import com.worksap.stm2016.model.SkillsetRepository;
import com.worksap.stm2016.model.Skilltable;
import com.worksap.stm2016.model.SkilltableRepository;
import com.worksap.stm2016.model.Ticket;
import com.worksap.stm2016.model.TicketRepository;
import com.worksap.stm2016.model.Utils;

@Controller
public class RestController {
	
	@Autowired
	private Utils utils;
	
	@Autowired
	private TicketRepository ticketRepo;
	
	@Autowired
	private EmployeelistRepository employeeRepo;
	
	@Autowired
	private SkillsetRepository skillRepo;
	
	@Autowired
	private SkilltableRepository skilltableRepo;
	
    @RequestMapping(value="/ticketstable", produces = "application/json")
    @ResponseBody
    public void handleAllTickets(@RequestParam Map<String,String> params,
						  Writer responseWriter) throws SQLException, IOException {
    	//get action type
    	String action = params.get("action");
    	String tid = params.get("tid");
    	if(action.equals("list")){
    		try{
    			List<Ticket> ticketList = (List<Ticket>) ticketRepo.findAll();
    			long sum = ticketRepo.count();
    			
	        	Gson gson = new Gson();
        		JsonElement element = gson.toJsonTree(ticketList, new TypeToken<List<Ticket>>() {}.getType());
        		JsonArray jsonArray = element.getAsJsonArray();
        		String listData=jsonArray.toString();
        		//data format required by jTable
        		listData="{\"Result\":\"OK\",\"Records\":"+listData+",\"TotalRecordCount\":"+sum+"}";
        		//System.out.println(listData);
        		responseWriter.write(listData);
        	}catch(Exception ex){
        		String error="{\"Result\":\"ERROR\",\"Message\":"+ex.getStackTrace()+"}";
        		responseWriter.write(error);
        	}
    	}else if (action.equals("update")){
    		try{
    			// remove key 'action' so that we can convert map to object
    			 params.remove("action");
    			 params.forEach((key,value)->System.out.println(key+" : "+value));
    			 ObjectMapper mapper = new ObjectMapper(); // jackson's objectmapper
    			 Ticket ticket = mapper.convertValue(params, Ticket.class);
    			 ticketRepo.save(ticket);
    			 Gson gson = new Gson();
    			 JsonElement element = gson.toJsonTree(ticket, new TypeToken<Ticket>() {}.getType());
    			 String result = element.getAsJsonObject().toString();
    			 result = "{\"Result\":\"OK\",\"Record\":"+ result +"}";
         		 //System.out.println(result);
 				 responseWriter.write(result);
    		}catch(Exception ex){
        		String error="{\"Result\":\"ERROR\",\"Message\":"+ex.getStackTrace()+"}";
        		responseWriter.write(error);
        	}
    	}else if (action.equals("delete")){
    		try{
    			ticketRepo.delete(tid);
    			responseWriter.write("{\"Result\":\"OK\"}");
    		}catch(Exception ex){
        		String error="{\"Result\":\"ERROR\",\"Message\":\"Only unchecked tickets can be deleted.\"}";
        		responseWriter.write(error);
        	}
    	}
   }

    @RequestMapping(value="/allemployees", produces = "application/json")
    @ResponseBody
    public void handleAllEmployees(@RequestParam Map<String,String> params,
						  Writer responseWriter) throws SQLException, IOException {
    	//get action type
    	String action = params.get("action");
    	
    	if(action.equals("list")){
    		try{
    			List<Employeelist> employeeList = (List<Employeelist>) employeeRepo.findAllByOrderByEidAsc();
/* 
 * A ManyToMany map will result in loop reference in Gson, we use Jackson instead    		
 */
    			OutputStream out = new ByteArrayOutputStream();
    		    ObjectMapper mapper = new ObjectMapper();
    		    mapper.writeValue(out, employeeList);
    		    String listData = out.toString();
        		listData="{\"Result\":\"OK\",\"Records\":"+listData+"}";
        		//System.out.println(listData);
        		responseWriter.write(listData);
        	}catch(Exception ex){
        		String error="{\"Result\":\"ERROR\",\"Message\":"+ex.getStackTrace()+"}";
        		responseWriter.write(error);
        	}
    	}else if (action.equals("create")||action.equals("update")){
    		try{
    			// watch params
    			params.remove("action");
    			params.forEach((key,value)->System.out.println(key+" : "+value));
    			
    			OutputStream out = new ByteArrayOutputStream();
    		    ObjectMapper mapper = new ObjectMapper();
    		    Employeelist emp = mapper.convertValue(params, Employeelist.class);
    		    employeeRepo.save(emp);
    		    mapper.writeValue(out, emp);
    		    String result = out.toString();
    			result = "{\"Result\":\"OK\",\"Record\":"+ result +"}";
 				responseWriter.write(result);
    		}catch(Exception ex){
        		String error="{\"Result\":\"ERROR\",\"Message\":"+ex.getStackTrace()+"}";
        		responseWriter.write(error);
        	}
    	}else if (action.equals("delete")){
    		try{
    			employeeRepo.delete(Long.valueOf(params.get("eid")));
    			responseWriter.write("{\"Result\":\"OK\"}");
    		}catch(Exception ex){
        		String error="{\"Result\":\"ERROR\",\"Message\":\"You cannot delete employees with Tickets assigned or Skills not empty. Please finish related tickets or clear his/her skills.\" }";
        		responseWriter.write(error);
        	}
    	}
   }
    
    @RequestMapping(value="/skill", produces = "application/json")
    @ResponseBody
    public void showskill(@RequestParam Map<String,String> params,
						  Writer responseWriter) throws SQLException, IOException {
    	//get action type
    	String action = params.get("action");
    	Long eid = Long.valueOf(params.get("employeeId"));
    	if(action.equals("list")){
    		try{
    			List<Skilltable> skillSet = skilltableRepo.findByEid(eid);
    			OutputStream out = new ByteArrayOutputStream();
    		    ObjectMapper mapper = new ObjectMapper();
    		    mapper.writeValue(out, skillSet);
    		    String listData = out.toString();
        		//data format required by jTable
        		listData="{\"Result\":\"OK\",\"Records\":"+listData+",\"TotalRecordCount\":"+skillSet.size()+"}";
        		//System.out.println(listData);
        		responseWriter.write(listData);
        	}catch(Exception ex){
        		String error="{\"Result\":\"ERROR\",\"Message\":"+ex.getStackTrace()+"}";
        		responseWriter.write(error);
        	}
    	}else if (action.equals("update")||action.equals("create")){
    		try{

    			Skilltable st = null;
    			if (params.containsKey("sid")){
    				int sid = Integer.valueOf(params.get("sid"));
    				st = skilltableRepo.findBySid(sid);
    			}
    			if (st == null) st = new Skilltable();
    			st.setSkillset(skillRepo.findBySkillId(Integer.valueOf(params.get("skillId"))));
    			st.setEmployee(employeeRepo.findByEid(eid));
    			Skilltable newst = skilltableRepo.save(st);
    			OutputStream out = new ByteArrayOutputStream();
    		    ObjectMapper mapper = new ObjectMapper();
    		    mapper.writeValue(out, newst);
    		    String result = out.toString();
    			result = "{\"Result\":\"OK\",\"Record\":"+ result +"}";
         		System.out.println(result);
 				responseWriter.write(result);
    		}catch(Exception ex){
        		String error="{\"Result\":\"ERROR\",\"Message\":"+ex.getStackTrace()+"}";
        		responseWriter.write(error);
        	}
    	}else if (action.equals("delete")){
    		try{
    			int sid = Integer.valueOf(params.get("sid"));
    			skilltableRepo.delete(sid);
    			responseWriter.write("{\"Result\":\"OK\"}");
    		}catch(Exception ex){
        		String error="{\"Result\":\"ERROR\",\"Message\":"+ex.getStackTrace()+"}";
        		responseWriter.write(error);
        	}
    	}
   }
   
    @RequestMapping(value="/autocomplete", produces = "application/json")
    @ResponseBody
    public List<String> complete(@RequestParam Map<String,String> params){
    	if (params.containsKey("location"))
    		return utils.findTicketLocationList();
    	else if (params.containsKey("name"))
    		return utils.findTicketNameList();
    	else if (params.containsKey("phone"))
    		return utils.findTicketPhoneList();
    	return null;
    }
    
    @RequestMapping(value="/forceUpdateWorkerStatus")
    @ResponseBody
    public String forceUpdate(@RequestParam Map<String,String> params){
    	return utils.forceUpdateWorkerStatus(params.get("tid"));
    }
    
    @RequestMapping(value="/updateTicketStatus")
    @ResponseBody
    public String updateTicketStatus(@RequestParam Map<String,String> params){
    	return utils.updateTicketStatus();
    }
    
    @RequestMapping(value="/findTicketByEid", produces = "application/json")
    @ResponseBody
    public List<Map<String,Object>> findTicketByEid(@RequestParam Map<String,String> params){
    	return utils.findTicketByEid(Long.valueOf(params.get("eid")));
    }
    
    @RequestMapping(value="/getEmployeeBySkill", produces = "application/json")
    @ResponseBody
    public List<Map<String,Object>> findEmployeeListBySkill(@RequestParam Map<String,String> params){
    	return utils.findEmpticketBySkillId(Integer.valueOf(params.get("skillid")));
    }
    
    @RequestMapping(value="/findEmployeeByEid", produces = "application/json")
    @ResponseBody
    public Map<String,Object> findEmployeeListByEid(@RequestParam Map<String,String> params){
    	return utils.findEmpticketByEid(Long.valueOf(params.get("eid"))).get(0);
    }
}
