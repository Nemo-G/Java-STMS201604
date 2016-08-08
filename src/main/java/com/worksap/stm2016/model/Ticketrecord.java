package com.worksap.stm2016.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.Data;


/**
 * The persistent class for the ticketrecord database table.
 * 
 */
@Entity
@EntityListeners({TicketAssignEvent.class})
@Table(name="ticketrecord")
@Data
public class Ticketrecord implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	@GeneratedValue
	private Integer rid;

	private Integer evaluation = 5;
	private boolean accepted = false;
	
	@ManyToOne
	@JoinColumn(name="tid")
	private Ticket ticket;

	@ManyToOne
	@JoinColumn(name="eid")
	private Employeelist employee;
}