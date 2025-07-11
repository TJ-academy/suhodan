package com.example.suhodan.member.mypage;

import java.util.List;

public interface MypageDAO {
	List<MypageDTO> getUserBadge(String user_id);
	MypageDTO badgeDetail(String user_id, int badge_id);
}
