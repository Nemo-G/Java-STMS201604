package com.worksap.stm2016.model;

import javax.persistence.PostPersist;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.messaging.simp.SimpMessagingTemplate;

@Configurable
public class TicketAssignEvent {
	@Autowired
	private SimpMessagingTemplate smTemplate;
	
	//EntityListeners
	@PostPersist
	public void websocketNotifyInsert(final Ticketrecord tr){
		/*
		 * In this callback class, @Autowired annotation will not work correctly.
		 * But this solution will work by adding beans to applicationContext
		 * https://guylabs.ch/2014/02/22/autowiring-pring-beans-in-hibernate-jpa-entity-listeners/
		 * Another warning is that, AutowiredHelper must be registered in Spring Configuration files
		 */
		AutowireHelper.autowire(this, this.smTemplate);
		System.out.println(this.smTemplate);
		
		smTemplate.convertAndSend("/topic/employee/"+tr.getEmployee().getEid(), tr.getTicket());
	

	}
	
	
	
}