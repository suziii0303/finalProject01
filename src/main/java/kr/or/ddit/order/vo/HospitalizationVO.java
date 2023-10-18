package kr.or.ddit.order.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class HospitalizationVO {
	private String hsptlzNo;
	private String patCode;
	private String treatNo;
	private int hsptlzPayment;
	private String hsptlzInDate;
	private String hsptlzOutDate;
	private int sckBdNo;
	private int sckrmNo;
    private String patName;
    private String patHsptlzInDate;
    private String patHsptlzOutPlan;
    private String patHsptlzStatus;
    private String patIhidnum;
    private String patAddr;
    private String patDtlAddr;
    private String patTel;
    private String empNm;
    private String hsptlzYs;
    
    // 추가 
    private String keyword;
}
