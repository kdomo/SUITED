package suited.com.dto;

public class BasketDTO { //장바구니 DTO

	private String id; //사용자의 아이디
	private String product_code; //제품 코드
	private int quantity; // 수량
	
	public BasketDTO() {}
	
	public BasketDTO(String id, String product_code, int quantity) {
		super();
		this.id = id;
		this.product_code = product_code;
		this.quantity = quantity;
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

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
}
