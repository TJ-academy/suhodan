package com.example.suhodan.legend;

import java.util.List;

public interface SearchDonationDAO {
    List<SearchDonationDTO> searchFromLocation(String location);
}
