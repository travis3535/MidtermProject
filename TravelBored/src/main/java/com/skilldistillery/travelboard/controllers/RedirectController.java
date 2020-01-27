package com.skilldistillery.travelboard.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.travelboard.data.DAOSearch;
import com.skilldistillery.travelboard.data.DAOUser;
import com.skilldistillery.travelboard.entities.Event;
import com.skilldistillery.travelboard.entities.Location;
import com.skilldistillery.travelboard.entities.User;
import com.skilldistillery.travelboard.entities.UserEvent;

@Controller
public class RedirectController {
	
	@Autowired
	private DAOUser daoUser;
	
	@Autowired
	private DAOSearch daoSearch;
	
	@RequestMapping(path = {"/", "gotoLanding.do"}, method= RequestMethod.GET)
	private String landingPage() {
		return "landing";
	}

	@RequestMapping(path = "login.do", method= RequestMethod.POST)
	public String home( HttpSession session, String email, String password) {
		
		User user = daoUser.login(email, password);
		
		
		if (user == null) {
			return "landing";
		} else {
			
			session.setAttribute("loggedInUser", user);
			return "home";
		}
		
	}
	@RequestMapping(path = "gotoHome.do", method= RequestMethod.GET)
	public String login(HttpSession session) {
	User user =	(User) session.getAttribute("loggedInUser");
		
		if (user == null) {
			return "landing";
		} else {
			
			return "home";
		}
		
	}
	
	@RequestMapping(path = "gotoRegister.do", method = RequestMethod.GET)
	private String goToRegister(HttpSession session) {
		User user =	(User) session.getAttribute("loggedInUser");

		
		if (user == null) {
			return "register";
		} else {
			
			return "home";
		}
		
		
	}
	
	@RequestMapping(path = "gotoProfile.do", method = RequestMethod.GET)
	private String goToProfile(HttpSession session, Model model) {
		User user =	(User) session.getAttribute("loggedInUser");
		user = daoUser.findUserById(user.getId());
		session.setAttribute("loggedInUser", user);

		if (user == null) {
			return "landing";
		}else {
			List<Location> locations = daoSearch.findAllLocations();
			
			model.addAttribute("locations", locations);
			List<Event> events = new ArrayList<>();
			System.out.println("Some shit");
			for (UserEvent uEvent: user.getUserEvents()) {
				events.add(uEvent.getEvent());
				System.out.println(uEvent.getEvent().getId());
			}
			
			model.addAttribute("userEvents", events);
			return "profile";
		}
	}
	

	
	@RequestMapping(path = "gotoCrUpdateEvent.do", method = RequestMethod.GET)
	private String goToCrUpdateEvent(HttpSession session, Model model) {
		User user =	(User) session.getAttribute("loggedInUser");

		if (user == null) {
			return "event";
		}else {
			List<Location> locations = daoSearch.findAllLocations();
			model.addAttribute("locations", locations);
		return "crupdateevent";
		}
		
	}
	
	
	
}
