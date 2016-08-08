package com.worksap.stm2016.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.Data;

import java.sql.Timestamp;


/**
 * The persistent class for the attendance database table.
 * 
 */
@Data
@Entity
@Table(name="attendance")
public class Attendance implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false, length=20)
	private String tid;

	private int eid;
}