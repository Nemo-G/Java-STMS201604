package com.worksap.stm2016.model;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name="userlist")
public class Userlist {
	@Id
	@Column(name="uid")
    @GeneratedValue( strategy = GenerationType.AUTO )
	private long uid;
	
	private String name;
	private String password;
	private boolean enabled = false;
	@ManyToOne
	@JoinColumn(name="utype_id")
	private Utypelist utype = new Utypelist();
	
	
}
