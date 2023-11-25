package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {
	
	@RequestMapping("/testController")
	public String showTest() {
		System.out.println("[TestController][/testController]");
		return "join";
	}
	
}
