package com.example.suhodan.member.mypage;

import java.util.List;

public interface MypageDAO {
	List<MypageDTO> getUserBadge(String user_id);
	MypageDTO badgeDetail(int userbadge_id);
	// 배지 목록 페이징용
	List<MypageDTO> getUserBadgesPaged(String user_id, int startRow, int endRow);

	// 총 배지 수
	int getUserBadgeCount(String user_id);
	
	
}
