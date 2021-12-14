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
			pstmt.setString(8, dto.getOrder_messege());
			pstmt.setString(9, dto.getDelivery_message());
	
			int rs = pstmt.executeUpdate();
			if (rs != 0)
				return rs;
		} 
		return -1;
	}
	
}
