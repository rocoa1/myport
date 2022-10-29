package com.spring.main.dao;

import com.spring.main.dto.JoinDTO;

public interface JoinDAO {

	int join(JoinDTO dto);

	String doubleCheckId(String chkId);

	String doubleCheckEmail(String chkEmail);

	String login(String id, String pw);
	
	

}
