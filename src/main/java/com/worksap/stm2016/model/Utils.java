package com.worksap.stm2016.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class Utils {
	@Autowired
	private JdbcTemplate jdbcTemplate;    
    
//    public HrList getHrById(String uid){
//    	try{
//    		List<HrList> hrList = jdbcTemplate.query("select * from hrlist where uid=?", 
//    				new Object[]{uid},
//    				BeanPropertyRowMapper.newInstance(HrList.class));
//    		if (hrList.isEmpty())
//    			return null;
//    		else
//    			return hrList.get(0);
//    		
//    	}catch(Exception e){
//    		System.out.println("getHrById error");
//    		e.printStackTrace();
//    		return null;
//    	}
//    }
//    
//  
	/*
	 * Complex search 
	 */
	public List<String> findTicketLocationList(){
		try{
			List<String> locList = this.jdbcTemplate.queryForList("select distinct(location) from tickets", String.class); 
			if (locList.isEmpty())
				return null;
			else 
				return locList;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	public List<String> findTicketNameList(){
		try{
			List<String> nameList = this.jdbcTemplate.queryForList("select distinct(consumer_name) from tickets", String.class); 
			if (nameList.isEmpty())
				return null;
			else 
				return nameList;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	public List<String> findTicketPhoneList(){
		try{
			List<String> phoneList = this.jdbcTemplate.queryForList("select distinct(consumer_phone) from tickets", String.class); 
			if (phoneList.isEmpty())
				return null;
			else 
				return phoneList;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	public String forceUpdateWorkerStatus(String tid){
		try{
			this.jdbcTemplate.update("update ticketrecord set accepted=true where tid=?",tid);
			return "OK";
		}catch(Exception e){
			e.printStackTrace();
			return "Error";
		}
	}
	
	public String updateTicketStatus(){
		try{
			this.jdbcTemplate.update("update tickets set status_id=4 where status_id=3");
			return "OK";
		}catch(Exception e){
			e.printStackTrace();
			return "Error";
		}
	}
	
	public List<Map<String, Object>> findEmpticketBySkillId(int skillId){
		try{
			List<Map<String, Object>> list = this.jdbcTemplate.queryForList(
					"select a.*,b.processing,b.count,b.avgeval from employeelist a "
					+ "left join skilltable c on a.eid=c.eid "
					+ "left join empticketview b on a.eid=b.eid "
					+ "where c.skill_id=? order by avgeval desc",new Object[]{skillId});
			return list;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	public List<Map<String, Object>> findEmpticketByEid(long eid){
		try{
			List<Map<String, Object>> list = this.jdbcTemplate.queryForList(
					"select a.*,b.processing,b.count,b.avgeval from employeelist a "
					+ "left join empticketview b on a.eid=b.eid "
					+ "where a.eid=?",new Object[]{eid});
			return list;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	public List<Map<String, Object>> findTicketByEid(long eid){
		try{
			List<Map<String, Object>> list = this.jdbcTemplate.queryForList(
					"select a.*,b.evaluation,b.accepted,b.rid from tickets a "
					+ "left join ticketrecord b on a.tid=b.tid "
					+ "where b.eid=? order by b.accepted",new Object[]{eid});
			return list;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	public List<Integer> findEmployerNumGroupBySkillId(){
		try{
			List<Integer> list = this.jdbcTemplate.queryForList(
					"select count(*) from ss1604c188_rd4.skilltable group by skill_id order by skill_id", Integer.class);
			return list;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
   
}
