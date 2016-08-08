package com.worksap.stm2016.model;

import java.io.Serializable;
import javax.persistence.*;
import lombok.Data;



/**
 * The persistent class for the tickets database table.
 * 
 */
@Entity
@EntityListeners({InstantmessageEvent.class})
@Table(name="tickets")
@Data
public class Ticket implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false, length=40)
	private String tid;

	@Column(name="consumer_name", length=20)
	private String consumerName;
	
	@Column(name="consumer_phone", length=20)
	private String consumerPhone;
	
	@Column(name="expected_date", length = 30)
	private String expectedDate;

	@Column(name="created_time", length = 30)
	private String createdTime;

	private String details;

	@Column(length=20)
	private String fee = "0";

	@Column(length=30)
	private String location;
	
	private int problemtype;

	@Column(name="status_id")
	private Integer statusId = 0;	

}