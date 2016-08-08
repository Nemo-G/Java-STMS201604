package com.worksap.stm2016.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.Data;


/**
 * The persistent class for the authlist database table.
 * 
 */
@Data
@Entity
@Table(name="instantmsg")
public class Instantmessage implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue
	@Column(unique=true, nullable=false)
	private Integer mid;
	
	private String createdtime;
	private String mcontent;
	private boolean hasread = false;

}