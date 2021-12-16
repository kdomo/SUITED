package suited.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.sun.net.httpserver.Authenticator.Result;

import suited.com.dto.OrderDTO;

public class OrderDAO {
	private BasicDataSource bds;

	public OrderDAO() {
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
	
	public int insert(OrderDTO dto) throws Exception {
		String sql = "insert into tbl_order values(concat(to_char(sysdate,'YYYYMMDD'),ltrim(to_char((seq_order.nextval),'000000'))) ,?,?,?,?,'0',null,?,?,?,?,?,null)";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getOrder_date());
			pstmt.setInt(3, dto.getOrder_amount());
			pstmt.setString(4, dto.getOrder_status());
			pstmt.setString(5, dto.getOrder_address());
			pstmt.setString(6, dto.getOrder_phone());
			pstmt.setString(7, dto.getOrder_name());
			pstmt.setString(8, dto.getOrder_message());
			pstmt.setString(9, dto.getDelivery_message());
	
			int rs = pstmt.executeUpdate();
			if (rs != 0)
				return rs;
		} 
		return -1;
	}
	
	
	public ArrayList<OrderDTO> getOrderList(String order_no_value,String id){
		String sql = "select * from tbl_order where order_no=? AND id=?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, order_no_value);
			pstmt.setString(2, id);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<OrderDTO> orderList = new ArrayList<>();
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
				int seq_pay = rs.getInt("seq_pay");
				
				
				orderList.add(new OrderDTO(order_no,order_id,order_date,order_amount,order_status,pay_yn,delivery_no,order_address,order_phone,order_name,order_message,delivery_message,seq_pay));
			}
			return orderList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int pay(int seq_pay,String order_no) throws Exception {
		String sql = "update tbl_order set seq_pay=?,pay_yn='1' where order_no=?"; 
				
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setInt(1, seq_pay);
			pstmt.setString(2, order_no);
	
			int rs = pstmt.executeUpdate();
			if (rs != 0)
				return rs;
		} 
		return -1;
	}
	
	public ArrayList<OrderDTO> selectAll() {
	      String sql = "select * from tbl_order";
	      
	      try(Connection con = this.getConnection();
	         PreparedStatement pstmt = con.prepareStatement(sql);) {
	         
	         ResultSet rs = pstmt.executeQuery();
	         
	         ArrayList<OrderDTO> list = new ArrayList<>();
	         
	         while(rs.next()) {
	            int order_no = rs.getInt("order_no");
	            String id2 = rs.getString("id2");
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
	            int seq_pay = rs.getInt("seq_pay");
	            list.add(new OrderDTO(order_date, id2, order_no, order_amount, 
	                  order_status, pay_yn, delivery_no, order_address, order_phone,
	                  order_name, order_message, delivery_message, seq_pay));
	         }
	         return list;
	      }catch(Exception e) {
	         e.printStackTrace();
	      }
	      return null;
	   }
	   
	   public OrderDTO selectById(String id) {
	      String sql = "select * from tbl_order where id=?";
	      
	      try(Connection con = this.getConnection();
	         PreparedStatement pstmt = con.prepareStatement(sql);) {
	         
	         pstmt.setString(1, id);
	         ResultSet rs = pstmt.executeQuery();
	         
	         OrderDTO dto = new OrderDTO();
	         
	         if(rs.next()) {
	            dto.setOrder_no(rs.getString("order_no"));
	            dto.setId(rs.getString("id2"));
	            dto.setOrder_date(rs.getString("order_date"));
	            dto.setOrder_amount(rs.getInt("order_amount"));
	            dto.setOrder_status(rs.getString("order_status"));
	            dto.setPay_yn(rs.getString("pay_yn"));
	            dto.setDelivery_no(rs.getString("delivery_no"));
	            dto.setOrder_address(rs.getString("order_address"));
	            dto.setOrder_phone(rs.getString("order_phone"));
	            dto.setOrder_name(rs.getString("order_name"));
	            dto.setOrder_message(rs.getString("order_message"));
	            dto.setDelivery_message(rs.getString("delivery_message"));
	            dto.setSeq_pay(rs.getInt("seq_pay"));
	         }
	         return dto;
	      }catch(Exception e) {
	         e.printStackTrace();
	      }
	      return null;
	   }
}
