package com.worksap.stm2016.model;



import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;


@RepositoryRestResource(collectionResourceRel = "skill", path = "skill")
public interface SkilltableRepository extends CrudRepository<Skilltable, Integer>{
	public Skilltable findBySid(int sid);
	
	@Query(nativeQuery = true, value = "select * from skilltable a where a.eid=:eid")
	public List<Skilltable> findByEid(@Param("eid") long eid);
	
	@Query(nativeQuery = true, value = "delete from skilltable a where a.eid=:eid")
	public void deleteByEid(@Param("eid") long eid);
}
