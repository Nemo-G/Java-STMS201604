package com.worksap.stm2016.model;
import java.util.List;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
@Entity
@Table(name="employeelist")
public class Employeelist {
	@Id
	@Column(name="eid")
	@GeneratedValue
	private Long eid;
	private String name;
	private int age;
	private char gender;
	private String diploma;
	private String phone;
	private String bankaccount;
	
	@Column(name="is_checked")
	private boolean isChecked = false;
	@Column(name="is_employed")
	private boolean isEmployed = false;
	
	@Column(name="online_status")
	private boolean isOnline = false;
	
	@JsonIgnore
	@OneToMany(mappedBy="employee")
	private List<Skilltable> skilltable;
	
	@JsonIgnore
	@OneToMany(mappedBy="employee")
	private List<Ticketrecord> ticketrecord;
	
	/*
	 * TODO employment start date and end date
	 */
}
