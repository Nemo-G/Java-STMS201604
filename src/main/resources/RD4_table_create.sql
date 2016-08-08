drop TABLE IF EXISTS ss1604c188_rd4.userlist;
CREATE TABLE ss1604c188_rd4.userlist
( uid varchar(20) NOT NULL,
  name varchar(30) NOT NULL,
  password varchar(20) NOT NULL,
  utype_id varchar(30),
  enabled boolean default true,
  CONSTRAINT userlist_pk PRIMARY KEY (uid)
);

﻿drop TABLE IF EXISTS ss1604c188_rd4.authlist;
CREATE TABLE ss1604c188_rd4.authlist
( auth_id int NOT NULL,
  auth_detail varchar(30),
  CONSTRAINT authlist_pk PRIMARY KEY (auth_id)
);

drop TABLE IF EXISTS ss1604c188_rd4.utypelist;
CREATE TABLE ss1604c188_rd4.utypelist
(
  utype_id int NOT NULL,
  utype_name varchar(30s),
  utype_auth varchar(50),
  CONSTRAINT utypelist_pk PRIMARY KEY (utype_id)
);

drop TABLE IF EXISTS ss1604c188_rd4.employeelist;
CREATE TABLE ss1604c188_rd4.employeelist
( 
  	uid varchar(20),
  	name varchar(30),
  	age int,
  	gender char(1),
  	skillset varchar(30),
  	is_checked boolean default false;
  	is_employed boolean default false;
    CONSTRAINT employeelist_pk PRIMARY KEY (uid)
);

drop TABLE IF EXISTS ss1604c188_rd4.skilltable;
CREATE TABLE ss1604c188_rd4.skilltable
( 
	id serial,
  	uid varchar(20),
  	skill_id int,
  	CONSTRAINT skilltable_pk PRIMARY KEY (id)
);

drop TABLE IF EXISTS ss1604c188_rd4.worktypelist;
CREATE TABLE ss1604c188_rd4.worktypelist
( 
	id serial,
  	name varchar(20),
  	basepay int,
  	is_fixedterm boolean,
  	
  	CONSTRAINT skilltable_pk PRIMARY KEY (wid)
);


drop TABLE IF EXISTS ss1604c188_rd4.ticketrecord;
CREATE TABLE ss1604c188_rd4.ticketrecord
(
	rid int not null,
	uid varchar(20) NOT NULL REFERENCES employeelist(uid),
    tid varchar(20) NOT NULL REFERENCES tickets(tid),
	evaluation int,
    CONSTRAINT ticketrecord_pk PRIMARY KEY (rid)
);

drop TABLE IF EXISTS ss1604c188_rd4.absencetable;
CREATE TABLE ss1604c188_rd4.absencetable
(
	uid varchar(20) NOT NULL,
	start_time timestamp,
	end_time timestamp,
	absent_reason varchar(300),
	CONSTRAINT absencetable_pk PRIMARY KEY (uid)
);

drop TABLE IF EXISTS ss1604c188_rd4.tickets;
CREATE TABLE ss1604c188_rd4.tickets
(
	tid varchar(20) NOT NULL,
	created_time timestamp DEFAULT now(),
	consumer_id varchar(20),
	location varchar(30),
	details varchar(100),
	fee varchar(20),
	status_id int default 0,
	CONSTRAINT tickets_pk PRIMARY KEY (tid)
);

drop TABLE IF EXISTS ss1604c188_rd4.consumerlist;
CREATE TABLE ss1604c188_rd4.consumerlist
(
	cid varchar(20) NOT NULL,
	name varchar(30) NOT NULL,
	phone varchar(20),
	CONSTRAINT consumerlist_pk PRIMARY KEY (cid)
);
--drop TABLE IF EXISTS ss1604c188_rd4.payrollsetting;
--CREATE TABLE ss1604c188_rd4.payrollsetting
--(
--	id int NOT NULL,
--	employee_type varchar(10),
--	base int,
--	method varchar(10),
--	tax_rate int,
--	CONSTRAINT payrollsetting_pk PRIMARY KEY (id)
--);
--
--drop TABLE IF EXISTS ss1604c188_rd4.transactiondetail;
--CREATE TABLE ss1604c188_rd4.transactiondetail
--(
--	tr_id int NOT NULL,
--	tr_name varchar(30),
--	tr_detail varchar(300),
--	process_id_list varchar(30),
--	CONSTRAINT transactiondetail_pk PRIMARY KEY (tr_id)
--);
--
--drop TABLE IF EXISTS ss1604c188_rd4.processdetail;
--CREATE TABLE ss1604c188_rd4.processdetail
--(
--	pr_id int NOT NULL,
--	pr_name varchar(30),
--	pr_detail varchar(300),
--	staff_uid_list varchar(30),
--	req_sysauth_list varchar(30),
--	CONSTRAINT processdetail_pk PRIMARY KEY (pr_id)
--);
--
--drop TABLE IF EXISTS ss1604c188_rd4.transactionstate;
--CREATE TABLE ss1604c188_rd4.transactionstate
--(
--	state_id serial,
--	tr_id int NOT NULL,
--	tr_active boolean default true,
--	current_pr_id int,
--	pr_state varchar(10),
--	start_time timestamp,
--	end_time timestamp,
--	staff_1 varchar(20),
--	staff_2 varchar(20),
--	CONSTRAINT transactionstate_pk PRIMARY KEY (state_id)
--);
--
--
--
