package com.worksap.stm2016.model;

import java.util.List;
import java.util.Map;

import javax.persistence.PostPersist;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.messaging.simp.SimpMessagingTemplate;

@Configurable
public class InstantmessageEvent {
	@Autowired
	private SimpMessagingTemplate smTemplate;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	//EntityListeners
	@PostPersist
	public void websocketNotifyInsert(final Ticket ticket){
		/*
		 * In this callback class, @Autowired annotation will not work correctly.
		 * But this solution will work by adding beans to applicationContext
		 * https://guylabs.ch/2014/02/22/autowiring-pring-beans-in-hibernate-jpa-entity-listeners/
		 * Another warning is that, AutowiredHelper must be registered in Spring Configuration files
		 */
		AutowireHelper.autowire(this, this.smTemplate);
		//System.out.println(this.smTemplate);
		smTemplate.convertAndSend("/topic/newticket", ticket.getTid());
		/*
		 * We are in a JPA transaction. Other repository is not allow here.
		 * Use jdbcTemplate to update instantmsg
		 */
		AutowireHelper.autowire(this, this.jdbcTemplate);
		
		jdbcTemplate.update("insert into instantmsg select max(mid)+1,'"+ticket.getCreatedTime()+"',false,'"+
								ticket.getTid()+"' from instantmsg");
		

	}
	
	
	
}
