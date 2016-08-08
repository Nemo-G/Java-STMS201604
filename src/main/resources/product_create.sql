DROP TABLE IF EXISTS ss1604c188_rd2.inviinfo;
CREATE TABLE ss1604c188_rd2.inviinfo
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

﻿DROP TABLE IF EXISTS ss1604c188_rd2.inviregister;
CREATE TABLE ss1604c188_rd2.inviregister
( uid varchar(20) NOT NULL REFERENCES ss1604c188_rd2.inviinfo(uid),
  examstate varchar(10) default '00000000',
  trainingstate int default 0,
  attendancestate varchar(10) default '00000000',
  CONSTRAINT inviregister_pk PRIMARY KEY (uid)
);

﻿DROP TABLE IF EXISTS ss1604c188_rd2.examinfo;
CREATE TABLE ss1604c188_rd2.examinfo
( id serial,
  examtime varchar(30),
  subject varchar(20),
  invinum int,
  allow_register boolean NOT NULL,
  allow_checkin boolean NOT NULL,
  CONSTRAINT examinfo_pk PRIMARY KEY (id)
);

DROP TABLE IF EXISTS ss1604c188_rd2.inviarrangement;
CREATE TABLE ss1604c188_rd2.inviarrangement
( id serial,
  room_id int,
  room_place varchar(30),
  invi1_id varchar(20),
  invi2_id varchar(20),
  invi3_id varchar(20),
  invi4_id varchar(20),
  backup_info varchar(50),
  examid int REFERENCES ss1604c188_rd2.examinfo(id),
  CONSTRAINT inviarrangement_pk PRIMARY KEY (id)
);

DROP TABLE IF EXISTS ss1604c188_rd2.examconfig;
CREATE TABLE ss1604c188_rd2.examconfig
( id serial,
  rule_name varchar(30),
  rule_content varchar(1000),
  CONSTRAINT examconfig_pk PRIMARY KEY (id)
);

insert into ss1604c188_rd2.examconfig (rule_name,rule_content) values 
('notice','Default Notification'),
('training_step','1'),
('training_resource','{type:json}')

