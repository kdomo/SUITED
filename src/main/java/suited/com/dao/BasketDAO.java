package suited.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import suited.com.dto.BasketDTO;
import suited.com.dto.MyBasketDTO;
import suited.com.dto.ProductDTO;

public class BasketDAO {
	private BasicDataSource bds;

	public BasketDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context) iCtx.lookup("java:comp/env");
			bds = (BasicDataSource) envCtx.lookup("jdbc/bds");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Connection getConnection() throws Exception {
		return bds.getConnection();
	}

	public int insert(BasketDTO dto){
		String sql = "insert into tbl_basket values(?, ?, ?)";

		try (Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getProduct_code());
			pstmt.setInt(3, dto.getQuantity());
			
			int rs = pstmt.executeUpdate();
			if (rs != -1)
				return rs;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<MyBasketDTO> selectCartById(String id) {
	String sql = "select * from tbl_basket full outer join tbl_product on tbl_basket.product_code = tbl_product.product_code where tbl_basket.id = ?";
	
	try(Connection con = this.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);) {
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<MyBasketDTO> list = new ArrayList<>();
		
		while(rs.next()) {
			String product_code = rs.getString("product_code");
			String product_name = rs.getString("product_name");
			int price = rs.getInt("price");
			String img_system_name = rs.getString("img_system_name");
			int quantity = rs.getInt("quantity");
			
			list.add(new MyBasketDTO(img_system_name, product_code, product_name, price, quantity));
		}
		return list;
	} catch (Exception e) {
		e.printStackTrace();
	}
	return null;
}
	
	public int countById(String id) {
		String sql = "select count(*) from tbl_basket where id = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int modQuantity(String id, String product_code, String modification) {
		if(modification.equals("!")) {
			String sql = "update tbl_basket set quantity = quantity + 1 where product_code = ? and id = ?";
			
			try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
				pstmt.setString(1, product_code);
				pstmt.setString(2, id);
				
				int rs = pstmt.executeUpdate();
				if(rs != -1) return rs;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}else if(modification.equals("-")) {
			String sql = "update tbl_basket set quantity = quantity - 1 where product_code = ? and id = ? and quantity >= 2";
			
			try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
				pstmt.setString(1, product_code);
				pstmt.setString(2, id);
				
				int rs = pstmt.executeUpdate();
				if(rs != -1) return rs;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		} else {
			return -1;
		}
	}
	
	public int deleteByCode(String product_code) {
		String sql = "delete from tbl_basket where product_code = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, product_code);
			int rs = pstmt.executeUpdate();
			
			if(rs != -1) return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
