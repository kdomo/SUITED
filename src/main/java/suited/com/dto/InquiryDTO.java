package suited.com.dto;

import java.text.SimpleDateFormat;

public class InquiryDTO {
	private int seq_inquiry;
	private String id;
	private String product_code;
	private String title;
	private String content;
	private String inquiry_date;
	private String answer_yn;
	private String answer;
	
	public InquiryDTO(){
		
	}
	
	public InquiryDTO(int seq_inquiry, String id, String product_code, String title, String content,
			long inquiry_date, String answer_yn, String answer) {
		super();
		this.seq_inquiry = seq_inquiry;
		this.id = id;
		this.product_code = product_code;
		this.title = title;
		this.content = content;
		this.inquiry_date = toStringDate(inquiry_date);
		this.answer_yn = answer_yn;
		this.answer = answer;
	}
	
	public InquiryDTO(int seq_inquiry, String id, String product_code, String title, String content,
			String inquiry_date, String answer_yn, String answer) {
		super();
		this.seq_inquiry = seq_inquiry;
		this.id = id;
		this.product_code = product_code;
		this.title = title;
		this.content = content;
		this.inquiry_date = inquiry_date;
		this.answer_yn = answer_yn;
		this.answer = answer;
	}
	
	public String toStringDate(long inquiry_date) {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	    return sdf.format(inquiry_date);
	   }
	
	public int getSeq_inquiry() {
		return seq_inquiry;
	}

	public void setSeq_inquiry(int seq_inquiry) {
		this.seq_inquiry = seq_inquiry;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getProduct_code() {
		return product_code;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getInquiry_date() {
		return inquiry_date;
	}

	public void setInquiry_date(String inquiry_date) {
		this.inquiry_date = inquiry_date;
	}

	public String getAnswer_yn() {
		return answer_yn;
	}

	public void setAnswer_yn(String answer_yn) {
		this.answer_yn = answer_yn;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

}
