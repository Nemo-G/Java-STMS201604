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
@Table(name="skillset")
public class Skillset implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="skill_id", unique=true, nullable=false)
	private Integer skillId;
	private String skillname;
	private String skilldetail;

}