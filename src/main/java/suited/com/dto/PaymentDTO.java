package suited.com.dto;

public class PaymentDTO {
	
	
	private String order_id;
	private int pay_price;
	private String pg;
	private String method;
	private String card_name;
	private String card_code;
	private String purchased_at;
	
	public PaymentDTO(String order_id, int pay_price, String pg, String method, String card_name, String card_code,
			String purchased_at) {
		super();
		this.order_id = order_id;
		this.pay_price = pay_price;
		this.pg = pg;
		this.method = method;
		this.card_name = card_name;
		this.card_code = card_code;
		this.purchased_at = purchased_at;
	}

	public String getOrder_id() {
		return order_id;
	}

	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}

	public int getPay_price() {
		return pay_price;
	}

	public void setPay_price(int pay_price) {
		this.pay_price = pay_price;
	}

	public String getPg() {
		return pg;
	}

	public void setPg(String pg) {
		this.pg = pg;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getCard_name() {
		return card_name;
	}

	public void setCard_name(String card_name) {
		this.card_name = card_name;
	}

	public String getCard_code() {
		return card_code;
	}

	public void setCard_code(String card_code) {
		this.card_code = card_code;
	}

	public String getPurchased_at() {
		return purchased_at;
	}

	public void setPurchased_at(String purchased_at) {
		this.purchased_at = purchased_at;
	}

	
}
