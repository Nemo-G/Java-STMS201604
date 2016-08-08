package com.worksap.stm2016.model;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.security.access.prepost.PreAuthorize;

@RepositoryRestResource(collectionResourceRel = "utype", path = "utype")
@PreAuthorize("hasRole('ROLE_HRM')")
public interface UtypelistRepository extends CrudRepository<Utypelist,Integer> {

}
