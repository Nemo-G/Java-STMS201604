package com.worksap.stm2016.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the utypelist database table.
 * 
 */
@Entity
@Table(name="utypelist")
@NamedQuery(name="Utypelist.findAll", query="SELECT u FROM Utypelist u")
public class Utypelist implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="utype_id", unique=true, nullable=false)
	private Integer utypeId;

	@Column(name="utype_auth", length=255)
	private String utypeAuth;

	@Column(name="utype_name", length=255)
	private String utypeName;

	public Utypelist() {
	}

	public Integer getUtypeId() {
		return this.utypeId;
	}

	public void setUtypeId(Integer utypeId) {
		this.utypeId = utypeId;
	}

	public String getUtypeAuth() {
		return this.utypeAuth;
	}

	public void setUtypeAuth(String utypeAuth) {
		this.utypeAuth = utypeAuth;
	}

	public String getUtypeName() {
		return this.utypeName;
	}

	public void setUtypeName(String utypeName) {
		this.utypeName = utypeName;
	}

}