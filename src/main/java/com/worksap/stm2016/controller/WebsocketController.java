package com.worksap.stm2016.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class WebsocketController {

    @MessageMapping("/ws")
    @SendTo("/topic/greetings")
    public String greeting(String message) throws Exception {
        //Thread.sleep(100); // simulated delay
        return "hello"+message;
    }

}