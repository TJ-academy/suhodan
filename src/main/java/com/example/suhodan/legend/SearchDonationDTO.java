package com.example.suhodan.legend;

import lombok.Data;

@Data
public class SearchDonationDTO {
    private int legendId;
    private String title;
    private String legendLocation;

    private int contentId;
    private String donationTitle;
    private String donationLocation;
}
