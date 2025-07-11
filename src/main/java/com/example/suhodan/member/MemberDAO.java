package com.example.suhodan.member;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface MemberDAO {
	List<MemberDTO> list();
	
	void insert(MemberDTO dto);
	
	MemberDTO detail(String user_id);
	
	void delete(String user_id);
	
	void update(MemberDTO dto);
	
	boolean check_passwd(String user_id, String passwd);
	
	boolean isUserIdExists(String user_id);
	
	String login(MemberDTO dto);

	void updatePassword(MemberDTO dto);
	
	int getTotalCount(Map<String, Object> param);
	
	List<MemberDTO> listPaging(Map<String, Object> param);

}
