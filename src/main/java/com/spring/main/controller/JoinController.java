package com.spring.main.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.main.dto.JoinDTO;
import com.spring.main.service.JoinService;


@Controller
public class JoinController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired JoinService service;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		return "login";
	}
	
	@RequestMapping(value = "/login.go", method = RequestMethod.GET)
	public String logingo(Locale locale, Model model) {
		
		return "login";
	}
	
	@RequestMapping(value = "/join.go", method = RequestMethod.GET)
	public String Joingo(Locale locale, Model model) {
		
		return "joinPage";
	}
	
	@RequestMapping(value = "/idFind.go", method = RequestMethod.GET)
	public String idFind(Locale locale, Model model) {
		
		return "idFind";
	}
	
	@RequestMapping(value = "/pwFind.go", method = RequestMethod.GET)
	public String pwFind(Locale locale, Model model) {
		
		return "pwFind";
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Locale locale, Model model) {
		
		return "list";
	}
	
	
		//회원가입
		@RequestMapping(value = "/join.do")
		@ResponseBody
		public ModelAndView join(Model model, @ModelAttribute JoinDTO dto, HttpServletRequest request) {
			
			logger.info("id : "+dto.getMb_id());
			logger.info("pw : "+dto.getMb_pw());
			logger.info("email : "+dto.getMb_email());
			logger.info("name : "+dto.getMb_name());
			logger.info("gender : "+dto.getMb_gender());
			logger.info("postcode : "+dto.getMb_postcode());
			logger.info("addr : "+dto.getMb_addr_default());
			logger.info("detailaddr : "+dto.getMb_addr_detail());
			logger.info("sido : "+dto.getMb_sido());
			logger.info("sigungu : "+dto.getMb_sigungu());
			
			return service.join(dto);
	
		}
		
		//아이디 중복 체크
		@RequestMapping("/doubleCheckId.ajax")
		@ResponseBody
		public HashMap<String, Object> doubleCheckId(@RequestParam String chkId) {
					

		logger.info("아이디 중복 체크 : "+chkId);
		return service.doubleCheckId(chkId);
		}
		
		//이메일 중복 체크
		@RequestMapping("/doubleCheckEmail.ajax")
		@ResponseBody
		public HashMap<String, Object> doubleCheckEmail(@RequestParam String chkEmail) {
						
		logger.info("이메일 중복 체크 : "+chkEmail);
		return service.doubleCheckEmail(chkEmail);
		}
		
		
		//로그인
		@RequestMapping(value = "/login.do")
		public String login(Model model,@RequestParam String id, @RequestParam String pw, HttpServletRequest request) {
			
			String loginId = service.login(id, pw);
			logger.info("로그인한 아이디 : "+loginId);
			
			String msg = "아이디 또는 비밀번호를 확인 하세요";
			String page = "login";
			
			if(loginId != null) {
				HttpSession session =  request.getSession();
				session.setAttribute("loginId", loginId);
				page = "redirect:/list";		
			}else {
				model.addAttribute("msg", msg);			
			}
			
			return page;
		}
		
		
}
		
		
