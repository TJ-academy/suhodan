package com.example.suhodan.member;

import java.util.List;
import java.util.Map;

import com.example.suhodan.reward.RewardDTO;

public interface MemberDAO {
	List<MemberDTO> list();
	
	List<MemberDTO> listPaging(Map<String, Integer> param);
	
	int getTotalCount();
	
	void insert(MemberDTO dto);
	
	MemberDTO detail(String user_id);
	
	void delete(String user_id);
	
	void update(MemberDTO dto);
	
	boolean check_passwd(String user_id, String passwd);
	
	boolean isUserIdExists(String user_id);
	
	String login(MemberDTO dto);
}
