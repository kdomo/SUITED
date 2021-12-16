package suited.com.dto;

import java.text.SimpleDateFormat;

public class OrderDTO {

	private String order_no;
	private String id;
	private String order_date;
	private int order_amount; // 주문총액 
	private String order_status; //'신규'
	private String pay_yn; //결제완료여부
	private String delivery_no;
	private String order_address;
	private String order_phone;
	private String order_name;
	private String order_message;
	private String delivery_message;
	private int seq_pay;
	
	public OrderDTO() {}

	public OrderDTO(String id, long order_date, int order_amount, String order_status,
			String order_address, String order_phone, String order_name, String order_message,
			String delivery_message) {
		super();
		this.id = id;
		this.order_date = toStringDate(order_date);
		this.order_amount = order_amount;
		this.order_status = order_status;
		this.order_address = order_address;
		this.order_phone = order_phone;
		this.order_name = order_name;
		this.order_message = order_message;
		this.delivery_message = delivery_message;
	}
	
	public OrderDTO(String order_no, String id, long order_date, int order_amount, String order_status, String pay_yn,
			String delivery_no, String order_address, String order_phone, String order_name, String order_message,
			String delivery_message, int seq_pay) {
		super();
		this.order_no = order_no;
		this.id = id;
		this.order_date = toStringDate(order_date);
		this.order_amount = order_amount;
		this.order_status = order_status;
		this.pay_yn = pay_yn;
		this.delivery_no = delivery_no;
		this.order_address = order_address;
		this.order_phone = order_phone;
		this.order_name = order_name;
		this.order_message = order_message;
		this.delivery_message = delivery_message;
		this.seq_pay = seq_pay;
	}
	
	public OrderDTO(String order_no, String id, String order_date, int order_amount, String order_status, String pay_yn,
			String delivery_no, String order_address, String order_phone, String order_name, String order_message,
			String delivery_message, int seq_pay) {
		super();
		this.order_no = order_no;
		this.id = id;
		this.order_date = order_date;
		this.order_amount = order_amount;
		this.order_status = order_status;
		this.pay_yn = pay_yn;
		this.delivery_no = delivery_no;
		this.order_address = order_address;
		this.order_phone = order_phone;
		this.order_name = order_name;
		this.order_message = order_message;
		this.delivery_message = delivery_message;
		this.seq_pay = seq_pay;
	}


	public String getOrder_no() {
		return order_no;
	}

	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOrder_date() {
		return order_date;
	}

	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}

	public int getOrder_amount() {
		return order_amount;
	}

	public void setOrder_amount(int order_amount) {
		this.order_amount = order_amount;
	}

	public String getOrder_status() {
		return order_status;
	}

	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}

	public String getPay_yn() {
		return pay_yn;
	}

	public void setPay_yn(String pay_yn) {
		this.pay_yn = pay_yn;
	}

	public String getDelivery_no() {
		return delivery_no;
	}

	public void setDelivery_no(String delivery_no) {
		this.delivery_no = delivery_no;
	}

	public String getOrder_address() {
		return order_address;
	}

	public void setOrder_address(String order_address) {
		this.order_address = order_address;
	}

	public String getOrder_phone() {
		return order_phone;
	}

	public void setOrder_phone(String order_phone) {
		this.order_phone = order_phone;
	}

	public String getOrder_name() {
		return order_name;
	}

	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}

	public String getOrder_message() {
		return order_message;
	}

	public void setOrder_message(String order_message) {
		this.order_message = order_message;
	}

	public String getDelivery_message() {
		return delivery_message;
	}

	public void setDelivery_message(String delivery_message) {
		this.delivery_message = delivery_message;
	}

	public int getSeq_pay() {
		return seq_pay;
	}

	public void setSeq_pay(int seq_pay) {
		this.seq_pay = seq_pay;
	}

	public String toStringDate(long date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		return sdf.format(date);
	}
}
