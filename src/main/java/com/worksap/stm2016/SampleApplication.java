package com.worksap.stm2016;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import com.worksap.stm2016.model.AutowireHelper;

@SpringBootApplication
public class SampleApplication {
    public static void main(String[] args) {   	
        SpringApplication.run(SampleApplication.class, args);
    }
    
    
    //To inject beans in unmanaged class
    @Bean
    public AutowireHelper autowireHelper(){
        return AutowireHelper.getInstance();
    }
}
