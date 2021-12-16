package suited.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import suited.com.dto.PaymentDTO;


public class PaymentDAO {
	private BasicDataSource bds;

	public PaymentDAO() {
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

	
	public int insert(PaymentDTO dto) throws Exception {
		String sql = "insert into tbl_payment values(seq_pay.nextval,?,?,?,?,?,?)";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setInt(1, dto.getPay_price());
			pstmt.setString(2, dto.getPg());
			pstmt.setString(3, dto.getMethod());
			pstmt.setString(4, dto.getCard_name());
			pstmt.setString(5, dto.getCard_code());
			pstmt.setString(6, dto.getPurchased_at());

			int rs = pstmt.executeUpdate();
			if (rs != 0)
				return rs;
		} 
		return -1;
	}
	public int getseq() throws Exception {
		String sql = "select seq_pay.currval from dual";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			ResultSet rs = pstmt.executeQuery();
			if (rs.next())
				return rs.getInt(1);
		} 
		return -1;
	}
}
