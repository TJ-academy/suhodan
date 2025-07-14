package com.example.suhodan.donation;

import java.util.List;

public interface DonationHistoryDAO {
	List<DonationHistoryDTO> list(String donor_id);
}
