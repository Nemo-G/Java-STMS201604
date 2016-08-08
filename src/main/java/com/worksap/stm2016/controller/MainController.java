package com.worksap.stm2016.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.worksap.stm2016.model.InstantmessageRepository;
import com.worksap.stm2016.model.Skillset;
import com.worksap.stm2016.model.SkillsetRepository;
import com.worksap.stm2016.model.Ticket;
import com.worksap.stm2016.model.TicketRepository;

import com.worksap.stm2016.model.Userlist;
import com.worksap.stm2016.model.UserlistRepository;
import com.worksap.stm2016.model.Utils;



import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;



@Controller
public class MainController {

	@Autowired
	private Utils utils;
//	
//	@Autowired
//	private SimpMessagingTemplate smTemplate;
	
	@Autowired
	private UserlistRepository userRepo;
	
	@Autowired
	private TicketRepository ticketRepo;
	
	@Autowired
	private SkillsetRepository skillRepo;

	@Autowired 
	private InstantmessageRepository imRepo;
	
	private String getUserName(){
		User user = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String name = user.getUsername(); //get logged in username
        return name;
	}
	

    @RequestMapping("/login")
    public String forAdmin(){
    	System.out.println("login");
    	return "index";
    }
    
    @RequestMapping("/")
    public String forCustomer(){
    	//smTemplate.convertAndSend("/topic/greetings", "enter /");
    	return "reactEntry";
    }
    
    @RequestMapping("/welcome")
    public String dashboard(Map<String, Object> model,HttpServletRequest req){
    	HttpSession session = req.getSession();
    	if (session.getAttribute("user")== null){
    		String name = getUserName();
    		Userlist user = userRepo.findUserlistByName(name);
    		session.setAttribute("user", user);
    	}
    	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	model.put("dueTickets", ticketRepo.countByExpectedDate(sdf.format(now)));
    	model.put("uncheckedTickets", ticketRepo.countByStatusId(0) );
    	model.put("AssignWorker", ticketRepo.countByStatusId(1) );
    	model.put("WorkerAccepted",ticketRepo.countByStatusId(2));
    	model.put("TicketPrinted", ticketRepo.countByStatusId(3));
    	model.put("unreadMessageList", imRepo.findByHasread(false));
    	model.put("usr", session.getAttribute("user"));
    	return "welcome";
    }
    
   
    @RequestMapping(value = "/websocket")
    public String wsTest(@RequestParam Map<String,String> params,
    						Map<String,Object> model){
    	
    	return "websocketBoilerplate";
    }
//    
    @RequestMapping(value = "/skillconfig")
    public String handleTickets(Map<String,Object> model, HttpServletRequest req) {
	    HttpSession session = req.getSession();
		model.put("usr", session.getAttribute("user"));
		List<Skillset> skillSet = skillRepo.findAllByOrderBySkillIdAsc();
		model.put("skillset", skillSet);
		model.put("employeeNum",this.utils.findEmployerNumGroupBySkillId());
    	return "skillconfig";
    }
    
    @RequestMapping("/infomanagement")
    public String infomanaging(Map<String, Object> model, HttpServletRequest req) {
    	    HttpSession session = req.getSession();
    		model.put("usr", session.getAttribute("user"));		
    		return "infomanagement";
    }
    
    @RequestMapping("/ticket/all")
    public String allticket(Map<String, Object> model, HttpServletRequest req) {
    	    HttpSession session = req.getSession();
    		model.put("usr", session.getAttribute("user"));		
    		return "allticket";
    }
    
    @RequestMapping("/ticket/unfinished")
    public String handleUnfinishedTickets(Map<String,Object> model, HttpServletRequest req){
    	HttpSession session = req.getSession();
		model.put("usr", session.getAttribute("user"));	
    	List<Ticket> ticketList = ticketRepo.findByStatusIdLessThanOrderByStatusIdAscCreatedTimeAsc(5);
    	model.put("ticketList",ticketList);
    	String[] statusList = {"Unchecked","Assigning Worker","Worker Accepted","Ticket Printed","Ticket Finished"};
    	String[] tableStyle = {" danger"," warning"," success"," info"," "};
    	model.put("Status", statusList);
    	model.put("tableStyle", tableStyle);
    	return "unfinishedticket";
    }


}
