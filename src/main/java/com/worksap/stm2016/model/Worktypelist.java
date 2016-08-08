package com.worksap.stm2016.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.Data;


/**
 * The persistent class for the worktypelist database table.
 * 
 */
@Data
@Entity
@Table(name="worktypelist")
public class Worktypelist implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer wid;

	private Integer basepay;

	@Column(name="is_fixedterm")
	private Boolean isFixedterm;

	@Column(length=20)
	private String name;


}