package com.spring.main.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.main.dao.JoinDAO;
import com.spring.main.dto.JoinDTO;


@Service
public class JoinService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired JoinDAO dao;

	public ModelAndView join(JoinDTO dto) {
		
		int row = dao.join(dto);
		
		logger.info("join success : "+row);
		
		ModelAndView mav = new ModelAndView();
		String msg = "회원가입에 실패 했습니다.";
		String page = "join";
		
		if(row > 0) {
			msg = "회원가입에 성공 했습니다.";
			page = "login";
		}
		
		mav.addObject("msg", msg);
		mav.setViewName(page);
		
		return mav;
	}

	public HashMap<String, Object> doubleCheckId(String chkId) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String doubleId = dao.doubleCheckId(chkId);
		logger.info("중복 아이디가 있나? "+doubleId);
		
		boolean over = doubleId == null ? false : true;
		map.put("doubleId", over);
		
		return map;
	}

	public HashMap<String, Object> doubleCheckEmail(String chkEmail) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		String doubleEmail = dao.doubleCheckEmail(chkEmail);
		
		logger.info("중복 이메일이 있나? "+doubleEmail);
		boolean over = doubleEmail == null ? false : true;
		
		map.put("doubleEmail", over);
		
		return map;
	}


	public String login(String id, String pw) {
		
		return dao.login(id, pw);
	}

}
