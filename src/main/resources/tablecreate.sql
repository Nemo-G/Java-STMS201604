DROP TABLE if EXISTS inviinfo ;
CREATE TABLE inviinfo
( uid varchar(20) NOT NULL,
  name varchar(30) NOT NULL,
  password varchar(20) NOT NULL,
  phone varchar(20) NOT NULL,
  email varchar(30) NOT NULL,
  dept varchar(30) NOT NULL,
  credit int default 2,
  enabled boolean,
  bankaccount varchar(30),
  CONSTRAINT inviinfo_pk PRIMARY KEY (uid)
);

DROP TABLE if EXISTS inviregister;
CREATE TABLE inviregister
( uid varchar(20) NOT NULL REFERENCES inviinfo(uid),
  examstate varchar(10) default '00000000',
  trainingstate int default 0,
  attendancestate int default 0,
  CONSTRAINT inviregister_pk PRIMARY KEY (uid)
);

DROP TABLE if EXISTS examinfo;
CREATE TABLE examinfo
( id serial,
  examtime varchar(30),
  subject varchar(20),
  invinum int,
  allow_register boolean,
  allow_checkin boolean,
  CONSTRAINT examinfo_pk PRIMARY KEY (id)
);

DROP TABLE if EXISTS inviarrangement;
CREATE TABLE inviarrangement
( id serial,
  room_id int,
  room_place varchar(30),
  invi1_id varchar(20),
  invi2_id varchar(20),
  invi3_id varchar(20),
  invi4_id varchar(20),
  backup_info varchar(50),
  examtime varchar(30),
  CONSTRAINT inviarrangement_pk PRIMARY KEY (id)
);

DROP TABLE if EXISTS examconfig;
CREATE TABLE examconfig
( id serial,
  rule_name varchar(30),
  rule_content varchar(1000),
  CONSTRAINT examconfig_pk PRIMARY KEY (id)
);

insert into examconfig (rule_name,rule_content) values 
('notice','Default Notification'),
('training_step','1'),
('training_resource','{type:json}')


/*
 * Table Create SQL for RD4
 * 
 * */

drop TABLE IF EXISTS hrlist;
CREATE TABLE hrlist
( uid varchar(20) NOT NULL,
  name varchar(30) NOT NULL,
  password varchar(20) NOT NULL,
  dept_list varchar(30),
  sysauth_list varchar(30),
  enabled boolean default true,
  utype varchar(10) default 'deptHR',
  CONSTRAINT hrlist_pk PRIMARY KEY (uid)
);

drop TABLE IF EXISTS sysauthlist;
CREATE TABLE sysauthlist
( auth_id int NOT NULL,
  auth_detail varchar(30),
  CONSTRAINT sysauthlist_pk PRIMARY KEY (auth_id)
);

drop TABLE IF EXISTS deptlist;
CREATE TABLE deptlist
(
  dept_id int NOT NULL,
  dept_name varchar(30),
  CONSTRAINT deptlist_pk PRIMARY KEY (dept_id)
);

drop TABLE IF EXISTS temployeelist;
CREATE TABLE temployeelist
( 
	tid serial,
  	uid varchar(20),
  	name varchar(30),
  	age int,
  	gender char(1),
  	cv varchar(30),
  	agency_id int,
  	dept_id int,
  	start_date date,
  	end_date date,
  	termination_reason varchar(300),
  	authentication_level int default 5,
  CONSTRAINT temployeelist_pk PRIMARY KEY (tid)
);

drop TABLE IF EXISTS agencylist;
CREATE TABLE agencylist
( agency_id int NOT NULL,
  agency_detail varchar(50),
  CONSTRAINT agencylist_pk PRIMARY KEY (agency_id)
);

drop TABLE IF EXISTS attendancetable;
CREATE TABLE attendancetable
(
	uid varchar(20) NOT NULL,
	start_time timestamp,
	end_time timestamp,
	working_hour interval,
	CONSTRAINT attendancetable_pk PRIMARY KEY (uid)
);

drop TABLE IF EXISTS absencetable;
CREATE TABLE absencetable
(
	uid varchar(20) NOT NULL,
	start_time timestamp,
	end_time timestamp,
	absent_reason varchar(300),
	CONSTRAINT absencetable_pk PRIMARY KEY (uid)
);

drop TABLE IF EXISTS disciplinerecord;
CREATE TABLE disciplinerecord
(
	uid varchar(20) NOT NULL,
	check_date date,
	check_type int,
	details varchar(1000),
	CONSTRAINT disciplinerecord_pk PRIMARY KEY (uid)
);

drop TABLE IF EXISTS payrollsetting;
CREATE TABLE payrollsetting
(
	id int NOT NULL,
	employee_type varchar(10),
	base int,
	method varchar(10),
	tax_rate int,
	CONSTRAINT payrollsetting_pk PRIMARY KEY (id)
);

drop TABLE IF EXISTS transactiondetail;
CREATE TABLE transactiondetail
(
	tr_id int NOT NULL,
	tr_name varchar(30),
	tr_detail varchar(300),
	process_id_list varchar(30),
	CONSTRAINT transactiondetail_pk PRIMARY KEY (tr_id)
);

drop TABLE IF EXISTS processdetail;
CREATE TABLE processdetail
(
	pr_id int NOT NULL,
	pr_name varchar(30),
	pr_detail varchar(300),
	staff_uid_list varchar(30),
	req_sysauth_list varchar(30),
	CONSTRAINT processdetail_pk PRIMARY KEY (pr_id)
);

drop TABLE IF EXISTS transactionstate;
CREATE TABLE transactionstate
(
	state_id serial,
	tr_id int NOT NULL,
	tr_active boolean default true,
	current_pr_id int,
	pr_state varchar(10),
	start_time timestamp,
	end_time timestamp,
	staff_1 varchar(20),
	staff_2 varchar(20),
	CONSTRAINT transactionstate_pk PRIMARY KEY (state_id)
);



