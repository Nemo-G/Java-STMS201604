package com.worksap.stm2016.model;

import lombok.Data;

@Data
public class HrList {
	private String uid;
	private String name;
	private String password;
	boolean enabled;
	private String dept_list;
	private String sysauth_list;
	private String utype;
}
