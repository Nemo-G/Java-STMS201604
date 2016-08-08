package com.worksap.stm2016.model;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;


@RepositoryRestResource(collectionResourceRel = "employee", path = "employee")
public interface EmployeelistRepository extends PagingAndSortingRepository<Employeelist, Long>{
	public List<Employeelist> findAllByOrderByEidAsc();
	public Employeelist findByEid(@Param("eid") long eid);
	
	@Query(nativeQuery = true, value = "select b.* from skilltable a left join employeelist b on a.eid=b.eid where a.skill_id=:skillId")
	public List<Employeelist> findBySkillId(@Param("skillId") int skillId);
	
    public List<Employeelist> findByNameContaining(@Param("name") String name);
    public List<Employeelist> findByNameContainingAndEidContainingAndPhoneContaining(@Param("name") String name,
    		@Param("eid") long eid, @Param("phone") String phone);
    public List<Employeelist> findByAgeBetween(@Param("bottom") int bottom, @Param("top") int top);
    
    @Query(nativeQuery = true, value = "select * from employeelist t where t.is_employed=:employ")
    public List<Employeelist> findByEmployingStatus(@Param("employ") boolean employed);
    
    @Query(nativeQuery = true, value = "select * from employeelist a where a.is_checked=:check")
    public List<Employeelist> findByCheckingStatus(@Param("check") boolean checked); 
    
}
