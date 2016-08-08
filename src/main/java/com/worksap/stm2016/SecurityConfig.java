package com.worksap.stm2016;

import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	DataSource dataSource;
	
	@Autowired
	public void configAuthentication(AuthenticationManagerBuilder auth) throws Exception {
		
	  auth
	  .jdbcAuthentication().dataSource(dataSource)
		.usersByUsernameQuery(
			"select name as username,password, enabled from userlist where name=?")
		.authoritiesByUsernameQuery(
			"select a.name as username, b.utype_auth as authority from userlist a " + 
				"left join utypelist b on a.utype_id = b.utype_id where a.name=?");
	  //.inMemoryAuthentication()
		 /*
      .withUser("invi1").password("invi1").roles("USER")
      .and()
	  .withUser("admin1").password("admin1").roles("ADMIN")
	  
	  ;
	 
		
	  */
	}	
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {

	  http.authorizeRequests()
	    .antMatchers("/webjars/**","/","/css/*","/js/*").permitAll()//add "/rest/**" for curl test
	    .regexMatchers(HttpMethod.GET, "/rest/tickets/(.+)").permitAll()
	    .regexMatchers(HttpMethod.POST,"/skill(.+)").permitAll()
	    .antMatchers(HttpMethod.GET, "/rest/skillconfig/").permitAll()  
	    //POST should have CORS problems while testing at localhost:3000
	    .antMatchers(//HttpMethod.POST,
	    		"/rest/employee/**").permitAll()
	    .antMatchers(//HttpMethod.POST, 
	    		"/rest/tickets").permitAll() 
	    .antMatchers(//HttpMethod.POST,
	    		"/findTicketByEid").permitAll()
	    .antMatchers(//HttpMethod.POST,
	    		"/findEmployeeByEid").permitAll()
	    .anyRequest().authenticated()
        .and()
        .formLogin()
        .loginPage("/login")
        .defaultSuccessUrl("/welcome",true)
        .permitAll()
        .and()
        .logout()
        .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
        .logoutSuccessUrl("/login?logout")
        //.invalidateHttpSession(true)
        .and()
        .csrf().disable();
        
	}
}
