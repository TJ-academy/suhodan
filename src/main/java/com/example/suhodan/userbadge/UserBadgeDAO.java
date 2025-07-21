package com.example.suhodan.userbadge;

public interface UserBadgeDAO {
	int insertBadgeForQualifiedUsers(int transaction_id);
	String checkBadgeGranted(String user_id, int amount);
	String getBadgeLocationForUser(String user_id);
}
