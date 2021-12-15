package suited.com.dto;

public class MyBasketDTO {
	private String img_system_name;
	private String product_code;
	private String product_name;
	private int price;
	private int quantity;
	
	public MyBasketDTO() {}

	public String getImg_system_name() {
		return img_system_name;
	}

	public void setImg_system_name(String img_system_name) {
		this.img_system_name = img_system_name;
	}

	public String getProduct_code() {
		return product_code;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public MyBasketDTO(String img_system_name, String product_code, String product_name, int price, int quantity) {
		super();
		this.img_system_name = img_system_name;
		this.product_code = product_code;
		this.product_name = product_name;
		this.price = price;
		this.quantity = quantity;
	}

}
