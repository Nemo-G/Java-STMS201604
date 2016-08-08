package com.worksap.stm2016.model;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "ticketrecord", path = "ticketrecord")
public interface TicketrecordRepository  extends CrudRepository<Ticketrecord,Integer>{
	@Query(nativeQuery = true, 
			value = "select * from ticketrecord where tid=:tid")
	public List<Ticketrecord> findByTid(@Param("tid") String tid);
	
	@Query(nativeQuery = true, 
			value = "select count(*) from ticketrecord where eid=:eid")
	public int countByEid(@Param("eid") long eid);
	
	@Query(nativeQuery = true, 
			value = "select * from ticketrecord where eid=:eid")
	public List<Ticketrecord> findByEid(@Param("eid") long eid);
	
    @Query(nativeQuery = true, 
    		value = "select to_char(round(avg(evaluation),2),'9D99') from ticketrecord where eid=:eid")
	public String findStringAvgEvaluationByEid(@Param("eid") long eid); 
    
    @Query(nativeQuery = true, 
    		value = "update ticketrecord set accepted=true where tid=:tid")
	public void forceUpdateByTid(@Param("tid") String tid); 
}
