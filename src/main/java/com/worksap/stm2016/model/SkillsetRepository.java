package com.worksap.stm2016.model;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;


@RepositoryRestResource(collectionResourceRel = "skillconfig", path = "skillconfig")
public interface SkillsetRepository extends CrudRepository<Skillset,Integer> {
	public List<Skillset> findAllByOrderBySkillIdAsc();
	public Skillset findBySkillId(int skillId);
}
