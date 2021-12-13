package suited.com.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class ProductDTO {
	private String product_code;
	private String product_name;
	private int price;
	private String simple_content;
	private String main_content;
	private String written_product_date;
	private String img_origin_name;
	private String img_system_name;
	
	public ProductDTO() {}
	
	public String toStringDate(long date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		return sdf.format(date);
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

	public String getSimple_content() {
		return simple_content;
	}

	public void setSimple_content(String simple_content) {
		this.simple_content = simple_content;
	}

	public String getMain_content() {
		return main_content;
	}

	public void setMain_content(String main_content) {
		this.main_content = main_content;
	}

	public String getWritten_product_date() {
		return written_product_date;
	}

	public void setWritten_product_date(String written_product_date) {
		this.written_product_date = written_product_date;
	}

	public String getImg_origin_name() {
		return img_origin_name;
	}

	public void setImg_origin_name(String img_origin_name) {
		this.img_origin_name = img_origin_name;
	}

	public String getImg_system_name() {
		return img_system_name;
	}

	public void setImg_system_name(String img_system_name) {
		this.img_system_name = img_system_name;
	}

	public ProductDTO(String product_code, String product_name, int price, String simple_content, String main_content,
			long written_product_date, String img_origin_name, String img_system_name) {
		super();
		this.product_code = product_code;
		this.product_name = product_name;
		this.price = price;
		this.simple_content = simple_content;
		this.main_content = main_content;
		this.written_product_date = toStringDate(written_product_date);
		this.img_origin_name = img_origin_name;
		this.img_system_name = img_system_name;
	}
	
	public ProductDTO(String product_code, String product_name, int price, String simple_content, String main_content,
			String written_product_date, String img_origin_name, String img_system_name) {
		super();
		this.product_code = product_code;
		this.product_name = product_name;
		this.price = price;
		this.simple_content = simple_content;
		this.main_content = main_content;
		this.written_product_date = written_product_date;
		this.img_origin_name = img_origin_name;
		this.img_system_name = img_system_name;
	}
	
}
