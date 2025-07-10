package com.example.suhodan.donation;

import java.util.List;
import java.util.Map;

public interface DonationTransactionDAO {

	List<DonationTransactionDTO> list();
	List<DonationTransactionDTO> listPaging(Map<String, Integer> param);
	List<DonationListDTO> listPagingSearch(Map<String, Object> param);
	int getTotalCount(String searchOption, String keyword);
}
