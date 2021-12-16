package suited.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import suited.com.dto.ProductDTO;

public class ProductDAO {
	private BasicDataSource bds;
	
	public ProductDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() throws Exception{
		return bds.getConnection();
	}
	
	public int countAll() throws Exception{
		String sql = "select count(*) from tbl_product";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) return rs.getInt(1);
		}
		return -1;
	}
	
	public ArrayList<ProductDTO> getProductList(int startRange, int endRange) throws Exception{
		String sql = "select * from "
				+ "(select row_number() over(order by product_code desc) 순위,"
				+ "a.* from tbl_product a) "
				+ "where 순위 between ? and ? and product_code <> '000'";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, startRange);
			pstmt.setInt(2, endRange);
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ProductDTO> list = new ArrayList<>();
			while(rs.next()) {
				String product_code = rs.getString("product_code");
				String product_name = rs.getString("product_name");
				int price = rs.getInt("price");
				String written_product_date = rs.getString("written_product_date");
				String img_origin_name = rs.getString("img_origin_name");
				String img_system_name = rs.getString("img_system_name");
				
				list.add(new ProductDTO(product_code, product_name, price, null, null, written_product_date, img_origin_name, img_system_name));
			}
			return list;
		} 
	}
	
	public ArrayList<ProductDTO> selectAll() throws Exception{
		String sql = "select * from tbl_product";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ProductDTO> list = new ArrayList<>();
			
			while(rs.next()) {
				String product_code = rs.getString("product_code");
				String product_name = rs.getString("product_name");
				int price = rs.getInt("price");
				String simple_content = rs.getString("simple_content");
				String main_content = rs.getString("main_content");
				String written_product_date = rs.getString("written_product_date");
				String img_origin_name = rs.getString("img_origin_name");
				String img_system_name = rs.getString("img_system_name");
				
				list.add(new ProductDTO(product_code, product_name, price, simple_content, main_content, written_product_date, img_origin_name, img_system_name));
			}
			return list;
		} 
	}
	
	public ProductDTO selectByCode(String product_code) throws Exception{
		String sql = "select * from tbl_product where product_code = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, product_code);
			ResultSet rs = pstmt.executeQuery();
			
			ProductDTO dto = new ProductDTO();
			if(rs.next()) {
				dto.setProduct_code(rs.getString("product_code"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setPrice(rs.getInt("price"));
				dto.setSimple_content(rs.getString("simple_content"));
				dto.setMain_content(rs.getString("main_content"));
				dto.setWritten_product_date(rs.getString("written_product_date"));
				dto.setImg_origin_name(rs.getString("img_origin_name"));
				dto.setImg_system_name(rs.getString("img_system_name"));
				return dto;
			}
		} 
		return null;
	}
	
	public int insert(ProductDTO dto) throws Exception{
		String sql = "insert into tbl_product values(?, ?, ?, ?, ?, ?, ?, ?)";
		
		try(Connection con =this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setString(1, dto.getProduct_code());
			pstmt.setString(2, dto.getProduct_name());
			pstmt.setInt(3, dto.getPrice());
			pstmt.setString(4, dto.getSimple_content());
			pstmt.setString(5, dto.getMain_content());
			pstmt.setString(6, dto.getWritten_product_date());
			if(dto.getImg_origin_name() == null) {
				pstmt.setString(7, "이미지 없음");
				pstmt.setString(8, "이미지 없음");
			} else {
				pstmt.setString(7, dto.getImg_origin_name());
				pstmt.setString(8, dto.getImg_system_name());
			}
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		} 
		return -1;
	}
	
	public int modfifyByCode(String product_code, String product_name, int price, String simple_content, String main_content, String img_origin_name, String img_system_name) throws Exception{
		String sql = "update tbl_product set product_name = ?, price = ?, simple_content =?, main_content = ?, img_origin_name = ?, img_system_name = ? where product_code = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, product_name);
			pstmt.setInt(2, price);
			pstmt.setString(3, simple_content);
			pstmt.setString(4, main_content);
			pstmt.setString(5, img_origin_name);
			pstmt.setString(6, img_system_name);
			pstmt.setString(7, product_code);
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		} 
		return -1;
	}
	
	public int deleteByCode(String product_code) throws Exception{
		String sql = "delete from tbl_product where product_code = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, product_code);
			int rs = pstmt.executeUpdate();
			
			if(rs != -1) return rs;
		} 
		return -1;
	}
	
	public boolean checkProduct_code(String product_code) throws Exception{
		String sql = "select * from tbl_product where product_code = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, product_code);
			ResultSet rs = pstmt.executeQuery();
			
			// 입력된 product_code와 일치하는 값이 있으면 true, 없으면 false 반환
			if(rs.next()) return true;
		} 
		return false;
	}
}
