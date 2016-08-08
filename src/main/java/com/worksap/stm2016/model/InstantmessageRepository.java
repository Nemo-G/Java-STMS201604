package com.worksap.stm2016.model;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "instantmsg", path = "instantmsg")
public interface InstantmessageRepository extends CrudRepository<Instantmessage,Integer>{
	public List<Instantmessage> findByHasread(@Param("hasread") boolean hasread);
	
}
