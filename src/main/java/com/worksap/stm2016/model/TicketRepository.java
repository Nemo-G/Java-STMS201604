package com.worksap.stm2016.model;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface TicketRepository extends CrudRepository<Ticket,String>{
	public Ticket findByTid(@Param("tid") String tid);
	public List<Ticket> findByConsumerName(@Param("name") String name);
	public List<Ticket> findByConsumerPhone(@Param("phone") String phone);
	public List<Ticket> findByStatusIdLessThanOrderByStatusIdAscCreatedTimeAsc(int status);
	public int countByStatusId(int statusId);
	public int countByExpectedDate(String date);
}
