package com.example.suhodan.donation;

import java.util.List;

public interface DonationConDAO {
	List<DonationConDTO> list();
	
	DonationConDTO detail(int content_id);
	
	void update(DonationConDTO dto);
	
	void delete(int content_id);
	
	void insert(DonationConDTO dto);
	
	String file_info(int content_id);
}
