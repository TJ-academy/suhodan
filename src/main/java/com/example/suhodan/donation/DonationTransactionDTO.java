package com.example.suhodan.donation;

import java.util.Date;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@NoArgsConstructor
@Getter
@Setter
@ToString
public class DonationTransactionDTO {
    private int transaction_id;
    private int content_id;
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
}
