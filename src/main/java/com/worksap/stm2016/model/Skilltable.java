package com.worksap.stm2016.model;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;


/**
 * The persistent class for the skilltable database table.
 * 
 */
@Data
@Entity
@Table(name="skilltable")
public class Skilltable implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue
	private Integer sid;
	
//	@Column(name="skill_id")
//	private int skillId;
//	
//	@Column(name="eid")
//	private Long eid;
//	
	@ManyToOne
	@JoinColumn(name="skill_id")
	private Skillset skillset;
    
	@ManyToOne
	@JoinColumn(name="eid")
	private Employeelist employee;

}