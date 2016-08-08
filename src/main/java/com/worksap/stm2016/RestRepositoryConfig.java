package com.worksap.stm2016;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.data.rest.RepositoryRestProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestMvcConfiguration;

import com.worksap.stm2016.model.Employeelist;
import com.worksap.stm2016.model.Instantmessage;
import com.worksap.stm2016.model.Skillset;
import com.worksap.stm2016.model.Ticket;
import com.worksap.stm2016.model.Ticketrecord;
/*
 * Spring Data Rest will not expose Id by default.
 * Here is some trick I found.
 * http://tommyziegler.com/how-to-expose-the-resourceid-with-spring-data-rest/
 * Adding BRIAN SMITH comment
 */
@Configuration
@EnableConfigurationProperties(RepositoryRestProperties.class)
public class RestRepositoryConfig extends RepositoryRestMvcConfiguration {
	@Autowired
	private RepositoryRestProperties properties;

	@Bean
	@Override
	public RepositoryRestConfiguration config() {
		RepositoryRestConfiguration config = super.config();
		this.properties.applyTo(config);
	return config;
	}
	
    @Override
    protected void configureRepositoryRestConfiguration(RepositoryRestConfiguration config) {
    	
        config.exposeIdsFor(Skillset.class,Ticket.class,Instantmessage.class,Employeelist.class,Ticketrecord.class);
    }
}
