package suited.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.sun.net.httpserver.Authenticator.Result;

import suited.com.dto.OrderJoinDTO;


public class OrderJoinDAO {
	private BasicDataSource bds;

	public OrderJoinDAO() {
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


	
	
	public ArrayList<OrderJoinDTO> getOrderList(String order_no_value,String id){
		String sql = "select o.*,op.*,p.*\r\n"
				+ "from tbl_order o,tbl_order_product op,tbl_product p\r\n"
				+ "where o.order_no = op.order_no \r\n"
				+ "and op.product_code = p.product_code and o.order_no=? AND o.id=?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, order_no_value);
			pstmt.setString(2, id);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<OrderJoinDTO> orderJoinList = new ArrayList<>();
			if(rs.next()) {
				String order_no = rs.getString("order_no");
				String order_id = rs.getString("id");
				String order_date = rs.getString("order_date");
				int order_amount = rs.getInt("order_amount");
				String order_status = rs.getString("order_status");
				String pay_yn = rs.getString("pay_yn");
				String delivery_no = rs.getString("delivery_no");
				String order_address = rs.getString("order_address");
				String order_phone = rs.getString("order_phone");
				String order_name = rs.getString("order_name");
				String order_message = rs.getString("order_message");
				String delivery_message = rs.getString("delivery_message");
				String seq_pay = rs.getString("seq_pay");
				String product_code = rs.getString("product_code");
				int order_quantity = rs.getInt("order_quantity");
				String product_name = rs.getString("product_name");
				int price = rs.getInt("price");
				String simple_content = rs.getString("simple_content");
				String main_content = rs.getString("main_content");
				String written_product_date = rs.getString("written_product_date");
				String img_origin_name = rs.getString("img_origin_name");
				String img_system_name = rs.getString("img_system_name");
				
				orderJoinList.add(new OrderJoinDTO(order_no, order_id, order_date, order_amount, order_status,
						pay_yn, delivery_no, order_address, order_phone, order_name,
						order_message, delivery_message, seq_pay, product_code, order_quantity,
						product_name, price, simple_content, main_content, written_product_date,
						img_origin_name, img_system_name));
			}
			return orderJoinList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
