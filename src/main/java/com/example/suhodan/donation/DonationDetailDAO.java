package com.example.suhodan.donation;

import java.util.List;

public interface DonationDetailDAO {
	List<DonationDetailDTO> getDetail(int contentId, String donorId);
}
