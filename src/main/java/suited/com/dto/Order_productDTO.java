package suited.com.dto;

public class Order_productDTO {
	private String order_no;
	private String product_code;
	private int order_quantity;
	
	public Order_productDTO(String order_no, String product_code, int order_quantity) {
		super();
		this.order_no = order_no;
		this.product_code = product_code;
		this.order_quantity = order_quantity;
	}

	public String getOrder_no() {
		return order_no;
	}

	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}

	public String getProduct_code() {
		return product_code;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}

	public int getOrder_quantity() {
		return order_quantity;
	}

	public void setOrder_quantity(int order_quantity) {
		this.order_quantity = order_quantity;
	}
	
	
}
