package com.example.suhodan.donation;

import java.util.Date;

import lombok.Data;

@Data
public class DonationListDTO {
    private int transaction_id;
    private int content_id;
    private String content_title;
    private String donor_id;
    private int amount;
    private Date donation_date;
    private String payment_method;
    private String status;
    private String merchant_uid;
    private String imp_uid;
    private int refund_amount;
    private Date refund_date;
    private String refund_reason;
    private int reward_id;
    private String reward_name;
}
