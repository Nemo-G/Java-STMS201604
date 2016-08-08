package com.worksap.stm2016.model;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.security.access.prepost.PreAuthorize;

@RepositoryRestResource(collectionResourceRel = "user", path = "user")
public interface UserlistRepository extends CrudRepository<Userlist, Long> {
	public Userlist findUserlistByName(String name);
}
